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

/**
 * Citation: Code for CREATE route is adapted from Canvas, CS 340 Module 8
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968
 */
// CREATE ROUTE
router.post("/create", async function (req, res) {
    try {
        let data = req.body;

        const query = `CALL sp_CreateCustomer(?, ?, ?, ?, ?, ?, ?, @new_id);`;

        const [[[rows]]] = await db.query(query, [
            data.create_customer_name,
            data.create_customer_address,
            data.create_customer_city,
            data.create_customer_state,
            data.create_customer_zip,
            data.create_customer_phone,
            data.create_customer_email
        ]);

        console.log(
            `CREATE Customers. ID: ${rows.new_id} ` +
            `Customer Name: ${data.create_customer_name} ` +
            `Customer Address: ${data.create_customer_address} ` + `${data.create_customer_city} ` + `${data.create_customer_state} ` + `${data.create_customer_zip} ` +
            `Customer Phone: ${data.create_customer_phone} ` +
            `Customer Email: ${data.create_customer_email} `
        );

        res.redirect('/customers');
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

        if (isNaN(parseInt(data.update_customer_id)))
            data.update_customer_id = null;

        const updateQuery = `CALL sp_UpdateCustomer(?, ?, ?, ?, ?, ?, ?, ?);`;
        const selectQuery = `SELECT * FROM Customers WHERE customer_id = ?;`;

        await db.query(updateQuery, [
            data.update_customer_id,
            data.update_customer_name,
            data.update_customer_address,
            data.update_customer_city,
            data.update_customer_state,
            data.update_customer_zip,
            data.update_customer_phone,
            data.update_customer_email
        ]);
        const [[rows]] = await db.query(selectQuery, [
            data.update_customer_id
        ]);

        console.log(
            `UPDATE Customers. ID: ${data.update_customer_id} ` +
            `Customer Name: ${rows.name} ` +
            `Customer Address: ${rows.address} ` + `${rows.city} ` + `${rows.state} ` + `${rows.zip} ` +
            `Customer Phone: ${rows.phone} ` +
            `Customer Email: ${rows.email} `
        );

        res.redirect('/customers');
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

        const deleteQuery = `CALL sp_DeleteCustomer(?);`;
        await db.query(deleteQuery, [data.delete_customer_id]);

        console.log(
            `DELETE Customers. ID: ${data.delete_customer_id}`
        );

        res.redirect('/customers');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;