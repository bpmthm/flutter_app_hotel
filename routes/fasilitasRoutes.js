const express = require('express');
const router = express.Router();
const ctrl = require('../Controllers/fasilitasController');

router.get('/', ctrl.getAllFasilitas);
router.post('/', ctrl.tambahFasilitas);

module.exports = router;
