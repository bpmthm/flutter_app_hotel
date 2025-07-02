const mongoose = require('mongoose');

const fasilitasSchema = new mongoose.Schema({
  nama: { type: String, required: true },
  deskripsi: String,
  icon: String // opsional untuk simpan path/icon fasilitas
}, { timestamps: true });

module.exports = mongoose.model('Fasilitas', fasilitasSchema);
