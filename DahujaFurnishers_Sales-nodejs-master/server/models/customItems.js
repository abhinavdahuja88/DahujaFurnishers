/*
    mongoDB Schema for customItems

    false = free customItem
    true  = occupied customItem
*/

const mongoose = require ('mongoose');

var customItemschema = mongoose.Schema({
	name: {
        type: String,
        unique: true,
	   required: true,
    },
    availability: {
        type: Boolean,
        required: true,
        default: false
    }
});

var CustomItem = mongoose.model('CustomItem', customItemschema);

var customItems = {};
customItems["nocustomItem"] = false;


/*
	Function to put the default items in the system
*/
function populateDatabase () {
    for (prop in customItems) {
        var customItem = CustomItem({
            name: prop,
            availability: customItems[prop]
        });

		// simply save the default customItem in the system
        customItem.save().then((item) => {
			// do nothing
		}, (err) => {
			// do nothing
		});
    }
}

populateDatabase();

module.exports = {customItems, CustomItem};
