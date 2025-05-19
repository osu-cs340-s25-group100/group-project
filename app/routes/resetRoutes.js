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