/*
	mongoDB Schema for items
*/
const mongoose = require ('mongoose');

var itemschema = mongoose.Schema({
    name: {
        type: String,
        unique: true,
	   required: true 
    },
    items: {
        type: Number,
        required: true,
        default: 0
    }
});

var Item = mongoose.model('Item', itemschema);

/*
 	Default items in the system
		-> those will be added as soon as the system is live
		-> if they are deleted from the system, and the system restarts, then they will be added again in the system
*/

var scoreOfItem = {}; // empty map

module.exports = {scoreOfItem, Item};
