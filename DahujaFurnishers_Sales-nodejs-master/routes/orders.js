/*
     GET /app/addorder -> go to addOrder page
     POST /app/addorder                -> add a order in the database
     GET  /app/getorders               -> get a JSON with all orders
     GET  /app/order/:orderId   -> get one ordere data
     GET  /app/getorder/:orderId-> get JSON of a ordere data
     POST /app/updateorder/:orderId -> update item & items for order
     POST /app/delete/:orderId -> detele a order from the system
*/

const express = require('express');
const _ = require('lodash');
const kafka = require('kafka-node');
const router = express.Router();

var {scoreOfItem, Item} = require('./../server/models/items.js');
var {Order} = require('./../server/models/order.js');
var {Counter} = require('./../server/models/counter.js');
var {customItems, CustomItem} = require('./../server/models/customItems.js');
var isValidDate = require('is-valid-date');
const {ObjectID} = require('mongodb');
var syncGoogle = require('./../server/interfaces/quickstart.js');
var kafkaJs = require('./../server/db/kafka.js');
/*
    GET /app/addorder -> go to addOrder page
*/
router.get('/app/addorder', (req, res) => {
    res.render('addorder', {pageTitle: "Add order"});
});

/*
    POST /addOrder -> add new order
*/
router.post('/app/addorder', (req, res) => {
    // receive the items from the form in the array PD, each element being a String with the item name
    var PD = req.body.PD;

    // console.log(dateOfBirth);
    // console.log(isValidDate(dateOfBirth));

    if (_.isEmpty(PD)) {    // check if no item is selected
        PD = [];
    }


    // Check for empty fields
    if (_.isEmpty(req.body.name) || _.isEmpty(req.body.address)) {
        if (_.isEmpty(req.body.name)) req.flash('error_msg', 'Please enter the first name.');
        if (_.isEmpty(req.body.address)) req.flash('error_msg', 'Please enter the last name.');

        res.status(400).redirect('/app/addorder');
    } else {
        // set the sex of the new order
        // var sex = req.body.sex;
        // if (sex === "male") {
        //     sex = true;
        // } else {
        //     sex = false;
        // }
        // make a new order and add it in the database

        var order = Order({
            name: _.capitalize(req.body.name),
            address: _.capitalize(req.body.address),
            orderDate: req.body.orderDate,
            items: PD,
            lastUpdate: (new Date().getTime())
        });


        var details = [req.body.name,req.body.address,req.body.orderDate]
        console.log(details[0]);
        // Call Google Calendar
        syncGoogle.syncGoogleCalendar(details);

        order.save().then((order) => {
            order.updateScore();
            res.status(200).redirect('/app');
        }).catch((err) => {
            console.log(err);
            res.status(400).redirect('/app');
        });
   }
});

/*
    GET /app/getorders  -> get a JSON with all orders
*/
router.get('/app/getorders', (req, res) => {
    Order.find({}).then((orders) => {
// KAfka callback
kafkaJs.producer.send([{
topic: 'webevents.dev',
messages: orders.length,
attributes: 1 /* Use GZip compression for the payload */
}], function(error, result) {

if (error) {
  console.log("inside error")
  console.error(error);
}
});


        res.status(200).send(orders);
    }).catch((err) => {
        console.log(err);
        res.status(400).send();
    });
});

/*
    GET one order data -> for his personal page
*/
router.get('/app/order/:orderId', (req, res) => {
    orderId = req.params.orderId;
    console.log(orderId);
    Order.findOne({_id:orderId
    }).then((order) => {
        if (_.isEmpty(order)) {
            throw Error('Order does not exist');
        }
        res.status(200).render('orderPage');
    }).catch((err) => {
        console.log(err);
        res.status(404).redirect('/app');
    });
});

/*
    GET one order data and return it as JSON
*/
router.get('/app/getorder/:orderId', (req, res) => {
    orderId = req.params.orderId;
    Order.findOne({
        _id:orderId
    }).then((order) => {
        res.status(200).send(order);
    }).catch((err) => {
        req.flash('error_msg', 'Please enter the first name.');
        res.status(404).redirect('/app');
    });
});

/*
    POST /app/updateorder/:orderId -> update item & items for order
                                            -> request made from the orderPage
*/
router.post('/app/updateorder/:orderId', (req, res) => {
    orderId = req.params.orderId;

    // GET form attributes
    var PD = req.body.PD;
    if (_.isEmpty(PD)) {
        PD = [];
    }

    Order.findOneAndUpdate({
        _id:orderId
    }, {
        "$set": {
            "items": PD,
            "lastUpdate": (new Date().getTime())
         }
    },{
        new: true
    }).then((order) => {
        order.updateScore();
        res.redirect('/app/order/' + orderId);
    }).catch((err) => {
        console.log(err);
        res.redirect('/app/order/' + orderId);
    });
});

/*
    POST /app/delete/:orderId -> detele a order from the system
*/
router.get('/app/deleteorder/:orderId', (req, res) => {
    var orderId = req.params.orderId;

    Promise.all([CustomItem.find({}), Order.findOne({_id:orderId})])
        .then((data) => {
            var customItems = data[0];
            var order = data[1];

            // if the order is in a customItem, make the customItem empty
            if (order.customItem !== 'nocustomItem') {
                 for (var i = 0; i < customItems.length; ++i) {
                    if (customItems[i].name === order.customItem) {
                         customItems[i].availability = false;
                         customItems[i].save();
                         break;
                    }
                 }
            }

            order.remove().then((orders) => {
               res.status(200).redirect('/app');
            });
         }).catch((err) => {
            res.status(400).redirect('/app');
         });
});

module.exports = router;
