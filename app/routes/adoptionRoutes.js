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
        // Get all adoptions.
        const adoptions_query = `
        SELECT
            Adoptions.adoption_id,
            Adoptions.customer_id,
            Customers.name AS customer_name,
            Adoptions.pet_id,
            Pets.name AS pet_name,
            DATE_FORMAT(Adoptions.adoption_date, '%m/%d/%Y') AS adoption_date
        FROM Adoptions
        JOIN Customers
        ON Adoptions.customer_id = Customers.customer_id
        JOIN
        Pets
        ON Adoptions.pet_id = Pets.pet_id;`;

        const customers_query = `
        SELECT
            customer_id,
            name
        FROM Customers;
        `;

        const unadopted_pets_query = `
        SELECT
            pet_id,
            name
        FROM Pets
        WHERE pet_id NOT IN
        -- Subquery for ids of already adopted pets
        (
            SELECT pet_id
            FROM Adoptions
        );`;

        const [adoptions] = await db.query(adoptions_query);
        const [customers] = await db.query(customers_query);
        const [unadopted_pets] = await db.query(unadopted_pets_query);

        // Render adoptions.hbs
        res.render('adoptions', { adoptions, customers, unadopted_pets });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;