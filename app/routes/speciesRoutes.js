const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// NOTE: Adapted from GET endpoint in example code.
router.get('/', async function (req, res) {
    try {
        // Get all species.
        const species_query = `
        SELECT
            species_id,
            name
        FROM Species;`;

        const [species] = await db.query(species_query);

        // Render species.hbs
        res.render('species', { species });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;