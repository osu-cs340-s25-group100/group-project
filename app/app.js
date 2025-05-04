/**
 * CITATION: Everything in this file is copied from the example on Canvas
 * unless otherwise noted.
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
 */

// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// NOTE: This was added to use an .env file for the port.
require('dotenv').config();
const PORT =  process.env.PORT;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/adoptions', async function (req, res) {
    try {
        res.render('adoptions'); // Render the adoptions.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/customers', async function (req, res) {
    try {
        res.render('customers'); // Render the customers.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/locations', async function (req, res) {
    try {
        res.render('locations'); // Render the locations.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/species', async function (req, res) {
    try {
        res.render('species'); // Render the species.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/vaccinations', async function (req, res) {
    try {
        res.render('vaccinations'); // Render the vaccinations.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

app.get('/vaccines', async function (req, res) {
    try {
        res.render('vaccines'); // Render the vaccines.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

// NOTE: GET Pets endpoint is adapted from GET bsg-people endpoint in example code.
app.get('/pets', async function (req, res) {
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

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});