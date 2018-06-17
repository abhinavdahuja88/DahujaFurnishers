// GET /app/settings         -> go the settings

const express = require('express');
const router = express.Router();

var {scoreOfItem, Item} = require('./../server/models/items.js');

router.get('/app/systemsettings', (req, res) => {
    res.status(200).render('systemsettings', {pageTitle: "System settings"});
});

module.exports = router;
