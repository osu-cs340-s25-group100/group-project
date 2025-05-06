/**
 * CITATION:
 * The code in this file is adapted from the Node.js example on Canvas.
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
 * However, instead of putting the route handler in app.js,
 * we used router middleware to split the routes into multiple files.
 */

const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

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