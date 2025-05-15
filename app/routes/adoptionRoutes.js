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

/**
 * Citation: Code for CREATE route is adapted from Canvas, CS 340 Module 8
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
 */
// CREATE ROUTE
router.post("/create", async function (req, res) {
    try {
        let data = req.body;

        if (isNaN(parseInt(data.create_adoption_pet)))
            data.create_adoption_pet = null;
        if (isNaN(parseInt(data.create_adoption_customer)))
            data.create_adoption_customer = null;

        const query = `CALL sp_CreateAdoption(?, ?, ?, @new_id);`;

        const [[[rows]]] = await db.query(query, [
            data.create_adoption_customer,
            data.create_adoption_pet,
            data.create_adoption_date
        ]);

        console.log(
            `CREATE Adoptions. ID: ${rows.new_id} ` +
            `Customer ID: ${data.create_adoption_customer} ` +
            `Pet ID: ${data.create_adoption_pet} ` + 
            `Adoption Date: ${data.create_adoption_date}`
        );

        res.redirect('/adoptions');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

/**
 * Citation: Code for UPDATE route is adapted from Canvas, CS 340 Module 8
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
 */
// UPDATE ROUTE
router.post("/update", async function (req, res) {
    try {
        let data = req.body;

        if (isNaN(parseInt(data.update_adoption_pet)))
            data.update_adoption_pet = null;
        if (isNaN(parseInt(data.update_adoption_customer)))
            data.update_adoption_customer = null;

        const updateQuery = `CALL sp_UpdateAdoption(?, ?, ?, ?);`;
        const selectQuery = `SELECT * FROM Adoptions WHERE adoption_id = ?;`;

        await db.query(updateQuery, [
            data.update_adoption_id,
            data.update_adoption_customer,
            data.update_adoption_pet,
            data.update_adoption_date
        ]);
        const [[rows]] = await db.query(selectQuery, [
            data.update_adoption_id
        ]);

        console.log(
            `UPDATE Adoptions. ID: ${data.update_adoption_id} ` +
            `Customer ID: ${rows.customer_id} ` +
            `Pet ID: ${rows.pet_id} ` + 
            `Adoption Date: ${rows.adoption_date}`
        );

        res.redirect('/adoptions');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

/**
 * Citation: Code for DELETE route is from Canvas, CS 340 Module 8
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
 */
// DELETE ROUTE
router.post('/delete', async function (req, res) {
    try {
        let data = req.body;

        const deleteQuery = `CALL sp_DeleteAdoption(?);`;
        await db.query(deleteQuery, [data.delete_adoption_id]);

        console.log(
            `DELETE Adoptions. ID: ${data.delete_adoption_id}`
        );

        res.redirect('/adoptions');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;