const mongoose = require('mongoose');

const reservasiSchema = new mongoose.Schema({
  namaTamu: { type: String, required: true },
  email: {
  type: String,
  required: true,
  match: /.+\@.+\..+/},
  tipeKamar: { type: String, required: true },
  jumlahKamar: { type: Number, required: true },
  tanggalCheckIn: { type: Date, required: true },
  tanggalCheckOut: { type: Date, required: true },
  status: { 
  type: String, 
  enum: ['pending', 'dipesan', 'dibatalkan'], 
  default: 'pending'}
}, { timestamps: true });

module.exports = mongoose.model('Reservasi', reservasiSchema);
