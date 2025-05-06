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

module.exports = router;