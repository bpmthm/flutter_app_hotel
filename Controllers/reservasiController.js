const Reservasi = require('../models/Reservasi');

exports.getAllReservasi = async (req, res) => {
  const data = await Reservasi.find();
  res.json({ success: true, data });
};

exports.tambahReservasi = async (req, res) => {
  const reservasi = await Reservasi.create(req.body);
  res.status(201).json({ success: true, data: reservasi });
};

exports.updateStatus = async (req, res) => {
  const updated = await Reservasi.findByIdAndUpdate(
    req.params.id,
    { status: req.body.status },
    { new: true }
  );
  res.json({ success: true, data: updated });
};
