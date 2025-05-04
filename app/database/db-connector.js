/**
 * CITATION: Everything in this file is copied from the example on Canvas
 * unless otherwise noted.
 * Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-web-application-technology-2?module_item_id=25352948
 */

// Get an instance of mysql we can use in the app
let mysql = require('mysql2')
// NOTE: This line was added to use an .env file.
require('dotenv').config();

// Create a 'connection pool' using the provided credentials
// NOTE: This was changed to use an .env file.
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : process.env.CONNECTION_LIMIT || 10,
    host              : process.env.HOST,
    user              : process.env.USER,
    password          : process.env.PASSWORD,
    database          : process.env.NAME
}).promise(); // This makes it so we can use async / await rather than callbacks

// Export it for use in our application
module.exports = pool;