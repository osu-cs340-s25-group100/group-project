const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// NOTE: This is adapted from the example code on Canvas.
router.get('/', async function (req, res) {
    try {
        // Get all customers.
        const customers_query = `
        SELECT
            customer_id,
            name,
            address,
            city,
            state,
            zip,
            phone,
            email
        FROM Customers;`;

        const [customers] = await db.query(customers_query);

        // Render customers.hbs
        res.render('customers', { customers });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});
module.exports = router;