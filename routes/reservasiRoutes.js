const express = require('express');
const router = express.Router();
const ctrl = require('../Controllers/reservasiController');

router.get('/', ctrl.getAllReservasi);
router.post('/', ctrl.tambahReservasi);
router.patch('/:id', ctrl.updateStatus);

module.exports = router;
