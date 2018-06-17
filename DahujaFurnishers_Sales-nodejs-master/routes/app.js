// GET /app                  -> go the dashboard
// GET /app/addorder       -> go to addOrder page

const express = require('express');
const router = express.Router();

var {scoreOfItem, Item} = require('./../server/models/items.js');
var {Order} = require('./../server/models/order.js');
var {customItems, CustomItem} = require('./../server/models/customItems');

/*
    GET /app/ -> simply render the page
*/
router.get('/app', (req, res) => {
    res.status(200).render('dashboard');
});

router.get('/app/getGoogleCalendar', (req, res) => {
    res.status(200).render('googleCalendar');
});


module.exports = router;
