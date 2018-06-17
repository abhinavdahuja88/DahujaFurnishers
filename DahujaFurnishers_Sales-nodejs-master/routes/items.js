/*
    GET /app/getitems -> return JSON with all items in the system
    POST /app/additem -> add a new item in the system
    POST /app/deleteitem -> delete a item from the system
*/

const express = require('express');
const _ = require('lodash');
const router = express.Router();


var {scoreOfItem, Item} = require('./../server/models/items.js');
var {Order} = require('./../server/models/order.js');

/*
    GET /app/getitems -> return JSON with all items in the system, sorted alphabetically
*/
router.get('/app/getitems', (req, res) => {
    Item.find({}, null, {sort: {name: 1}}).then((items) => {
        // Facade pattern -> make a simple JSON object, containing just the items names and scoreOfItem
        //                -> to easily communicate with the frontend
        var scoreOfItemJSON = {};

        if (_.isArray(items)) {
            for (var i = 0; i < items.length; ++i) {
                scoreOfItemJSON[items[i].name] = items[i].items;
            }
        }

        res.setHeader('Content-Type', 'application/json');
        res.status(200).send(JSON.stringify(scoreOfItemJSON));
    }).catch((err) => {
        console.log(err);
        res.status(404).send();
    });
});

/*
    POST /app/additem -> add a new item in the system
*/
router.post('/app/additem', (req, res) => {
    var itemName = req.body.itemName;
    var itemscore = req.body.itemscore;

    // check that the name is a String and items is a Number
    if (_.isString(itemName) && !_.isNaN(itemscore)) {
        var item = Item({
            name: _.capitalize(itemName),
            items: itemscore
        });

        item.save().then((item) => {
            console.log('Item added');
            res.status(200).redirect('/app/systemsettings');
        }).catch((err) => {
            console.log(err);
            res.status(400).redirect('/app/systemsettings');
        });
    } else {
        res.status(400).redirect('/app/systemsettings',{messages: req.flash('success_msg', 'Succesful test') });
    }
});

/*
    POST /app/deleteitem -> delete a item from the system
*/
router.post('/app/deleteitems', (req, res) => {
    var itemsToDelete = req.body.DD;

    if (_.isArray(itemsToDelete)) {
        for (var i = 0; i < itemsToDelete.length; ++i) {
            // 1. Delete the item from the system
            var item = itemsToDelete[i];
            Item.find({
                name: itemsToDelete[i]
            }).remove().catch((err) => {
                console.log(err);
            });

            var promise = new Promise ((resolve, reject) => {
                 resolve(item);
                 reject(item);
            });

            // 2. Update all orders
            Promise.all([promise.then(function (item) { return item; }), Order.find({ items: item })])
                 .then((data) => {
                     var itemToDel = data[0];
                     console.log(itemToDel);
                     var orders = data[1];

                     for (var i = 0; i < orders.length; ++i) {
                          var order = orders[i];
                          var newitems = [];

                          // delete the items from the order items array
                          for (var j = 0; j < order.items.length; ++j)
                              if (order.items[j] !== itemToDel) {
                                   newitems.push(order.items[j]);
                              }

                          order.items = newitems;
                          order.lastUpdate = new Date().getTime();

                          order.save().then((order) => {
                               order.updateScore();
                          }).catch((err) => {
                               console.log(err);
                          });
                     }
                 }).catch((err) => {
                      console.log(err);
                 });
        }
        res.status(200).redirect('/app/systemsettings');
    } else {
        console.log("POST /app/deleteitem, itemsToDelete is not an array");
        res.status(400).redirect('/app/systemsettings');
    }
});

module.exports = router;
