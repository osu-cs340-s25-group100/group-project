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

// Routes
app.use('/pets', require('./routes/petRoutes'));
app.use('/customers', require('./routes/customerRoutes'));
app.use('/locations', require('./routes/locationRoutes'));
app.use('/species', require('./routes/speciesRoutes'));
app.use('/adoptions', require('./routes/adoptionRoutes'));
app.use('/vaccinations', require('./routes/vaccinationRoutes'));
app.use('/vaccines', require('./routes/vaccineRoutes'));


app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
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