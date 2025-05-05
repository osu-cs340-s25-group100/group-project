const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

router.get('/', async function (req, res) {
    try {
        res.render('locations'); // Render the locations.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

module.exports = router;