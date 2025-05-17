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

// reset route
router.post('/', async (req, res) => {
    try {
        const conn = await db.getConnection();
        await conn.query('CALL sp_ResetDatabase();');
        conn.release();

        const redirectTo = req.body.redirectTo || '/';
        res.redirect(redirectTo);
    } catch (err) {
        res.status(500).send('Reset failed');
    }
});

module.exports = router;