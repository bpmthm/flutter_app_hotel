const Fasilitas = require('../models/Fasilitas');

exports.getAllFasilitas = async (req, res) => {
  const data = await Fasilitas.find();
  res.json({ success: true, data });
};

exports.tambahFasilitas = async (req, res) => {
  const fasilitas = await Fasilitas.create(req.body);
  res.status(201).json({ success: true, data: fasilitas });
};
