const Kamar = require('../models/Kamar');

exports.getAllKamar = async (req, res) => {
  const data = await Kamar.find();
  res.json({ success: true, data });
};

exports.tambahKamar = async (req, res) => {
  const kamar = await Kamar.create(req.body);
  res.status(201).json({ success: true, data: kamar });
};
