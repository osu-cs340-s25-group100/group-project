const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// NOTE: Endpoint is adapted from GET endpoint in example code.
router.get('/', async function (req, res) {
    try {
        // Get all vaccines.
        const vaccines_query = `
        SELECT
            vaccine_id,
            name
        FROM Vaccines;`;

        const [vaccines] = await db.query(vaccines_query);

        // Render vaccines.hbs
        res.render('vaccines', { vaccines });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});


module.exports = router;