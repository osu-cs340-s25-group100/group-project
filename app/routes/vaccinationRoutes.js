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
        // Get all vaccinations.
        const vaccinations_query = `
        SELECT
            Vaccinations.vaccination_id,
            Vaccinations.pet_id,
            Pets.name AS pet_name,
            Vaccinations.vaccine_id,
            Vaccines.name AS vaccine_name,
            DATE_FORMAT(Vaccinations.vaccination_date, '%m/%d/%Y') AS vaccination_date
        FROM Vaccinations
        JOIN Pets
        ON Vaccinations.pet_id = Pets.pet_id
        JOIN Vaccines
        ON Vaccinations.vaccine_id = Vaccines.vaccine_id;`;

        const pets_query =
        `SELECT
            pet_id,
            name
        FROM Pets;`;

        const vaccines_query =
        `SELECT
            vaccine_id,
            name
        FROM Vaccines;`;

        const [vaccinations] = await db.query(vaccinations_query);
        const [pets] = await db.query(pets_query);
        const [vaccines] = await db.query(vaccines_query);

        // Render vaccinations.hbs
        res.render('vaccinations', { vaccinations, pets, vaccines });
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

        if (isNaN(parseInt(data.create_vaccination_pet)))
            data.create_vaccination_pet = null;
        if (isNaN(parseInt(data.create_vaccination_vaccine)))
            data.create_vaccination_vaccine = null;

        const query = `CALL sp_CreateVaccination(?, ?, ?, @new_id);`;

        const [[[rows]]] = await db.query(query, [
            data.create_vaccination_pet,
            data.create_vaccination_vaccine,
            data.create_vaccination_date
        ]);

        console.log(`CREATE Vaccinations. ID: ${rows.new_id} ` + `Pet ID: ${data.create_vaccination_pet} ` + `Vaccine ID: ${data.create_vaccination_vaccine} ` + `Vaccination Date: ${data.create_vaccination_date}`);

        res.redirect('/vaccinations');
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

        if (isNaN(parseInt(data.update_vaccination_pet)))
            data.update_vaccination_pet = null;
        if (isNaN(parseInt(data.update_vaccination_vaccine)))
            data.update_vaccination_vaccine = null;

        const updateQuery = `CALL sp_UpdateVaccination(?, ?, ?, ?);`;
        const selectQuery = `SELECT * FROM Vaccinations WHERE vaccination_id = ?;`;

        await db.query(updateQuery, [
            data.update_vaccination_id,
            data.update_vaccination_pet,
            data.update_vaccination_vaccine,
            data.update_vaccination_date
        ]);
        const [[rows]] = await db.query(selectQuery, [data.update_vaccination_id]);

        console.log(
            `UPDATE Vaccinations. ID: ${data.update_vaccination_id} ` + `Pet ID: ${rows.update_vaccination_pet} ` + 
            `Vaccine ID: ${rows.update_vaccination_vaccine} ` + `Vaccination Date: ${rows.update_vaccination_date}`
        );

        res.redirect('/vaccinations');
    } catch (error) {
        console.error('Error executing queries:', error);
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;