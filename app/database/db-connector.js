/**
 * CITATION:
 * The code in this file is adapted from the Node.js example on Canvas.
 * The credentials were moved into an .env.
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
 */

// Get an instance of mysql we can use in the app
let mysql = require('mysql2')

// Environmental variables
require('dotenv').config();

// Create a 'connection pool' using credentials from .env file
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : process.env.DB_CONNECTION_LIMIT,
    host              : process.env.DB_HOST,
    user              : process.env.DB_USER,
    password          : process.env.DB_PASSWORD,
    database          : process.env.DB_NAME
}).promise(); // This makes it so we can use async / await rather than callbacks

// Export it for use in our application
module.exports = pool;