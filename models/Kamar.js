const mongoose = require('mongoose');

const kamarSchema = new mongoose.Schema({
  nomor: { type: String, required: true, unique: true },
  tipe: { type: String, required: true },
  harga: { type: Number, required: true },
  tersedia: { type: Boolean, default: true },
  deskripsi: String
}, { timestamps: true });

module.exports = mongoose.model('Kamar', kamarSchema);
