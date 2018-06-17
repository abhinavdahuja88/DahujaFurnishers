const mongoose = require('mongoose');
const _ = require('lodash');
var {scoreOfItem, Item} = require('./items.js');
var customItems = require('./customItems.js');

// User Schema
var orderschema = mongoose.Schema({
	name: {
		type: String,
		required: true
	},
	address: {
		type: String,
		required: true
	},
	orderDate: {
		type: Date,
	},
	// dateOfBirth: {
	// 	type: String,
	// 	required: true,
	// },
	// sex: {
	// 	// true = male
	// 	// false = female
	// 	type: Boolean,
	// 	required: true,
	// 	default: true
	// },

	items: {
        type: Array,
        default: []
     },
     items: {
        type: String,
	   required: true,
	   default: 0
     },
	customItem: {
		type: String,
		required: true,
		default: 'nocustomItem'
	},
	lastUpdate: {
		type: Number,
		required: true
	}
});

/*
	function to update the items and the items of a order
	*Requires the order to have the items already saved in the databases
*/
orderschema.methods.updateScore = function () {
	var order = this;

	// promise to get the order object inside the items callback
	var promise = new Promise(function(resolve, reject) {
		resolve(order);
		reject(order);
	})

	Promise.all([promise.then(function (order) { return order; }), Item.find({})])
         .then((data) => {
             var order = data[0];
             var items = data[1];

             var scoreOfItem = {};
             var items = 0;

		   if (! _.isEmpty(items) && _.isArray(items)) {
                 // create a hashmap with the items and their scores
                 for (var i = 0; i < items.length; ++i) {
                     scoreOfItem[items[i].name] = items[i].items;
                 }

            	  for (var i = 0; i < order.items.length; ++i) {
	                if (scoreOfItem[order.items[i]] > items) {
	        			items = scoreOfItem[order.items[i]];
	        	 	 }
             	 }
             }

             order.items = items;
             order.save().catch((err) => {
			   console.log(err);
		   });
         }).catch((err) => {
             console.log(err);
	 });
}

var Order = mongoose.model('Order', orderschema);
module.exports = {Order};
