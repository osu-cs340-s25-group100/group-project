const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// NOTE: This is a adapted from the GET endpoint in example code.
router.get('/', async function (req, res) {
    try {
        // Get all shelters.
        const shelters_query = `
        SELECT
            location_id,
            name,
            address,
            city,
            state,
            zip
        FROM Locations;
        `;

        const [shelters] = await db.query(shelters_query);

        // Render shelters.hbs
        res.render('shelters', { shelters });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;