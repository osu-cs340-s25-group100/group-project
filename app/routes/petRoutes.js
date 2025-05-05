const express = require('express');
const router = express.Router();
const db = require('../database/db-connector');

// NOTE: GET Pets endpoint is adapted from GET bsg-people endpoint in example code.
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

module.exports = router;