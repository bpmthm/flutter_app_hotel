const express = require('express');
const router = express.Router();
const ctrl = require('../Controllers/kamarController');

router.get('/', ctrl.getAllKamar);
router.post('/', ctrl.tambahKamar);

module.exports = router;
