/*
    GET  /app/updatecustomItem/:orderId/:futureCustomItem'            -> put's order orderId in the customItem customItemName
    GET /app/swaporders/:orderWithCustomItem/:orderWithoutCustomItem   -> swap the customItems of two orders
    GET  /app/getcustomItems                                           -> return JSON with all customItems status in the system
    POST /app/addcustomItem                                            -> add a new customItem in the system
    POST /app/deletecustomItem                                         -> delete a item from the system
*/
const express = require('express');
const _ = require('lodash');
const router = express.Router();

var {Order} = require('./../server/models/order.js');
var {customItems, CustomItem} = require('./../server/models/customItems.js');
const {ObjectID} = require('mongodb');


/*
    GET /app/getcustomItems -> return JSON with all customItems status in the system
*/
router.get('/app/getcustomItems', (req, res) => {
    CustomItem.find({}, null, {sort: {name: 1}}).then((customItems) => {
        var customItemsJSON = {};
        // customItems is an array with all customItems
        for (var i = 0; i < customItems.length; ++i) {
            customItemsJSON[customItems[i].name] = customItems[i].availability;
        }

        res.setHeader('Content-Type', 'application/json');
        res.status(200).send(JSON.stringify(customItemsJSON));
    }).catch((err) => {
        console.log(err);
        res.setHeader('Content-Type', 'application/json');
        res.status(400).send(JSON.stringify({nocustomItem: false}));
    });
});

/*
    GET /app/updatecustomItem -> update the customItem of one order
*/
router.get('/app/updatecustomItem/:orderId/:futureCustomItem', (req, res) => {
    var orderId = req.params.orderId;
    var futureCustomItem = req.params.futureCustomItem;

    // var promise = new Promise(function(resolve, reject) {
    //      console.log("redirect from promise");
    //      resolve(redirect);
    //  });

    // 1. Check if the currentCustomItem is empty
    // 2. unassign the current customItem of the order
    // 3. assign him to the current customItem

    Promise.all([CustomItem.find({}), CustomItem.findOne({name: futureCustomItem}), Order.findOne({orderId: orderId})])
        .then((data) => {
            var customItems = data[0];
            var futureCustomItemObject = data[1];
            var order = data[2];


                // 1. Check if the currentCustomItem is empty
            if (customItems && order && futureCustomItemObject && futureCustomItemObject["availability"] === false) {  // check that all the parameters were OK
                // 2. unassign the current customItem of the order
                if (order.customItem !== 'nocustomItem') {
                    for (var i = 0; i < customItems.length; ++i) {
                        if (customItems[i].name === order.customItem) {
                            customItems[i].availability = false;
                            customItems[i].save();
                            break;
                        }
                    }
                }

                // 3. assign him to the current customItem
                order.customItem = futureCustomItemObject.name;
                order.save();

                // 4. Set the futureCustomItem to be busy
                if (futureCustomItemObject.name !== 'nocustomItem') {
                    // console.log("futureCustomItemObject.name", futureCustomItemObject.name);

                    for (var i = 0; i < customItems.length; ++i) {
                        if (customItems[i].name === futureCustomItemObject.name) {
                            customItems[i].availability = true;
                            customItems[i].save();
                            break;
                        }
                    }
                }
                res.redirect('/app');
            } else {
                throw Error("Bad request to change the customItem. Check the parameters.");
            }
        }).catch((err) => {
            console.log(err);
            res.redirect('/app');
        });
});

/*
    GET /app/swaporders/:orderWithCustomItem/:orderWithoutCustomItem -> swap the customItems of two orders
*/
router.get('/app/swaporders/:orderWithCustomItem/:orderWithoutCustomItem', (req, res) => {
    var orderWithCustomItem = req.params.orderWithCustomItem;
    var orderWithoutCustomItem = req.params.orderWithoutCustomItem;

    // 1. Unassign the current customItem of the orderWithCustomItem
    // 2. Assign nocustomItem to orderWithCustomItem
    // 3. Assign the customItem to orderWithoutCustomItem

    Promise.all([Order.findOne({orderId: orderWithCustomItem}), Order.findOne({orderId: orderWithoutCustomItem})])
        .then((data) => {
            var orderWithCustomItem = data[0];
            var orderWithoutCustomItem = data[1];

                // Check if the orders have customItem and not have a customItem
            if (orderWithCustomItem && orderWithoutCustomItem && orderWithCustomItem["customItem"] !== 'nocustomItem' && orderWithoutCustomItem["customItem"] === 'nocustomItem') {  // check that all the parameters were OK
                // 1. Unassign the current customItem of the orderWithCustomItem
                var customItemOfOrder = orderWithCustomItem["customItem"];

                orderWithCustomItem.customItem = "nocustomItem";
                orderWithCustomItem.save();

                orderWithoutCustomItem.customItem = customItemOfOrder;
                orderWithoutCustomItem.save();

                res.redirect('/app');
            } else {
                throw Error("Bad request to change the customItem. Check the parameters.");
            }
        }).catch((err) => {
            console.log(err);
            res.redirect('/app');
        });
});

/*
    POST /app/addcustomItem -> add a new customItem in the system
*/
router.post('/app/addcustomItem', (req, res) => {
    var customItemName = req.body.customItemName;

    // check that the name is a String
    if (_.isString(customItemName) && !_.isNaN(customItemName)) {
        var customItem = CustomItem({
            name: customItemName,
            availability: false
        });

        customItem.save().then((customItem) => {
            console.log('CustomItem added');
            res.status(200).redirect('/app/systemsettings');
        }).catch((err) => {
            console.log(err);
            res.status(400).redirect('/app/systemsettings');
        });
    } else {
        res.status(400).redirect('/app/systemsettings', {messages: req.flash('success_msg', 'CustomItem added succesfully.') });
    }
});

/*
    POST /app/deletecustomItem -> delete a customItem from the system
*/
router.post('/app/deletecustomItems', (req, res) => {
    var customItemsToDelete = req.body.RD;

    if (_.isArray(customItemsToDelete)) {
        for (var i = 0; i < customItemsToDelete.length; ++i) {
            CustomItem.find({
                name: customItemsToDelete[i]
            }).remove().catch((err) => {
                console.log(err);
            });

            Order.findOneAndUpdate({
                 customItem: customItemsToDelete[i]
            }, {
                 "$set": {
                   "customItem": "nocustomItem",
               }
          }).catch((err) => {
                 console.log(err);
            });
        }
        res.status(200).redirect('/app/systemsettings');
    } else {
        res.status(400).redirect('/app/systemsettings');
    }
});


module.exports = router;
