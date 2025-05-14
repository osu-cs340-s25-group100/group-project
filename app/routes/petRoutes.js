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
        // Get all pets.
        const pets_query = `
        SELECT
            Pets.pet_id,
            Pets.name,
            DATE_FORMAT(Pets.birthday, '%m/%d/%Y') AS birthday,
            DATE_FORMAT(Pets.date_arrived, '%m/%d/%Y') AS date_arrived,
            Pets.adoption_cost,
            Pets.gender,
            Species.name AS species,
            Locations.name AS shelter,
            Pet_Adoptions.adopted
        FROM Pets
        JOIN Locations
        ON Pets.location_id = Locations.location_id
        JOIN Species
        ON Pets.species_id = Species.species_id
        JOIN
        -- Subquery for adoption status for each pet.
        (
            SELECT
                Pets.pet_id,
                IF(
                    Adoptions.adoption_id IS NOT NULL,
                    "Y",
                    "N"
                ) AS adopted
            FROM Pets
            LEFT JOIN Adoptions
            ON Pets.pet_id = Adoptions.pet_id
        ) AS Pet_Adoptions
        ON Pets.pet_id = Pet_Adoptions.pet_id;`;

        const species_query = `SELECT * FROM Species`;

        const locations_query = `SELECT * FROM Locations`;

        const [pets] = await db.query(pets_query);
        const [species] = await db.query(species_query);
        const [locations] = await db.query(locations_query);

        // Render pets.hbs
        res.render('pets', { pets, species, locations });
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

        if (isNaN(parseInt(data.create_pet_species)))
            data.create_pet_species = null;
        if (isNaN(parseInt(data.create_pet_location)))
            data.create_pet_location = null;

        const query = `CALL sp_CreatePet(?, ?, ?, ?, ?, ?, ?, @new_id);`;

        const [[[rows]]] = await db.query(query, [
            data.create_pet_species,
            data.create_pet_location,
            data.create_pet_name,
            data.create_pet_birthday,
            data.create_pet_date_arrived,
            data.create_pet_adoption_cost,
            data.create_pet_gender
        ]);

        console.log(`CREATE Pets. ID: ${rows.new_id} ` + `Name: ${data.create_pet_name}`);

        res.redirect('/pets');
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

        if (isNaN(parseInt(data.create_pet_species)))
            data.create_pet_species = null;
        if (isNaN(parseInt(data.create_pet_location)))
            data.create_pet_location = null;

        const updateQuery = `CALL sp_UpdatePet(?, ?, ?, ?, ?, ?, ?, ?);`;
        const selectQuery = `SELECT name FROM Pets WHERE pet_id = ?;`;

        await db.query(updateQuery, [
            data.update_pet_id,
            data.update_pet_species,
            data.update_pet_location,
            data.update_pet_name,
            data.update_pet_birthday,
            data.update_pet_date_arrived,
            data.update_pet_adoption_cost,
            data.update_pet_gender
        ]);
        const [[rows]] = await db.query(selectQuery, [data.update_pet_id]);

        console.log(`UPDATE Pets. ID: ${data.update_pet_id} ` + `Name: ${rows.name}`);

        res.redirect('/pets');
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

        const deleteQuery = `CALL sp_DeletePet(?);`;
        await db.query(deleteQuery, [data.delete_pet_id]);

        console.log(`DELETE Pets. ID: ${data.delete_pet_id} ` +
            `Name: ${data.delete_pet_name}`
        );

        res.redirect('/pets');
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});

module.exports = router;