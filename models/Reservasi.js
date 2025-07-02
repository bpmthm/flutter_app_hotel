const mongoose = require('mongoose');

const reservasiSchema = new mongoose.Schema({
  namaTamu: { type: String, required: true },
  email: String,
  tipeKamar: { type: String, required: true },
  jumlahKamar: { type: Number, required: true },
  tanggalCheckIn: { type: Date, required: true },
  tanggalCheckOut: { type: Date, required: true },
  status: { type: String, enum: ['dipesan', 'dibatalkan'], default: 'dipesan' }
}, { timestamps: true });

module.exports = mongoose.model('Reservasi', reservasiSchema);
