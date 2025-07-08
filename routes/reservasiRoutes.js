const express = require('express');
const router = express.Router();
const Reservasi = require('../models/reservasi');
const jwt = require('jsonwebtoken');

// GET semua reservasi
router.get('/', async (req, res) => {
  try {
    const data = await Reservasi.find();
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
});

// POST Tambah reservasi (status default: dipesan)
router.post('/', async (req, res) => {
  try {
    const data = new Reservasi({
      ...req.body,
      status: 'pending' // default harus sesuai enum model
    });
    await data.save();
    res.status(201).json({ success: true, data });
  } catch (err) {
    console.error('Error saat menambahkan reservasi:', err.message);
    res.status(400).json({ success: false, message: err.message });
  }
});

// PATCH Update status booking (khusus admin)
router.patch('/:id', async (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) {
    return res
      .status(401)
      .json({ success: false, message: 'Token diperlukan' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    if (decoded.role !== 'admin') {
      return res
        .status(403)
        .json({ success: false, message: 'Hanya admin yang boleh update' });
    }

    const reservasi = await Reservasi.findByIdAndUpdate(
      req.params.id,
      { status: req.body.status },
      { new: true }
    );

    if (!reservasi) {
      return res
        .status(404)
        .json({ success: false, message: 'Reservasi tidak ditemukan' });
    }

    res.json({ success: true, data: reservasi });
  } catch (err) {
    res.status(400).json({ success: false, message: err.message });
  }
});

module.exports = router;
