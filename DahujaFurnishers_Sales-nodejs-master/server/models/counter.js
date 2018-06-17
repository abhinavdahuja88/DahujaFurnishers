/*
	mongoDB Schema for items
*/
const mongoose = require ('mongoose');

var counterschema = mongoose.Schema({
  _id: {type: String, required: true},
  seq: { type: Number, default: 0 }
});

var Counter = mongoose.model('Counter', counterschema);

module.exports = {Counter};
