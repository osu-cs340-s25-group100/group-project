/**
 * CITATION:
 * The code in this file is adapted from the Node.js example on Canvas.
 * Router middleware was used to split the routes into multiple files.
 * The port number was moved into an .env to make it configurable.
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
 */

// SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// Environmental Variables
require('dotenv').config();
const PORT =  process.env.PORT;

// ROUTES

app.use('/pets', require('./routes/petRoutes'));
app.use('/customers', require('./routes/customerRoutes'));
app.use('/shelters', require('./routes/shelterRoutes'));
app.use('/species', require('./routes/speciesRoutes'));
app.use('/adoptions', require('./routes/adoptionRoutes'));
app.use('/vaccinations', require('./routes/vaccinationRoutes'));
app.use('/vaccines', require('./routes/vaccineRoutes'));
app.use('/reset', require('./routes/resetRoutes'));

// Home
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page.');
    }
});

// LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});