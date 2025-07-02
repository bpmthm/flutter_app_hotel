require('dotenv').config();
const mongoose = require('mongoose');
const Kamar = require('./models/Kamar');
const Fasilitas = require('./models/Fasilitas');

mongoose.connect(process.env.MONGODB_URI)
  .then(() => {
    console.log('Koneksi MongoDB berhasil');
    return seedData();
  })
  .catch(err => console.error('Koneksi gagal:', err));

async function seedData() {
  try {
    await Kamar.deleteMany();
    await Fasilitas.deleteMany();

    await Kamar.insertMany([
      {
        nomor: 101,
        tipe: 'Standard',
        harga: 300000,
        kapasitas: 2,
        deskripsi: 'Kamar standar dengan 2 kasur single',
        gambar: 'https://source.unsplash.com/featured/?hotel-room',
        tersedia: true
      },
      {
        nomor: 102,
        tipe: 'Deluxe',
        harga: 450000,
        kapasitas: 3,
        deskripsi: 'Kamar deluxe dengan balkon dan city view',
        gambar: 'https://source.unsplash.com/featured/?luxury-hotel',
        tersedia: true
      }
    ]);

    await Fasilitas.insertMany([
      {
        nama: 'Kolam Renang',
        deskripsi: 'Kolam renang outdoor dengan pemandangan taman',
        gambar: 'https://source.unsplash.com/featured/?pool'
      },
      {
        nama: 'Wi-Fi',
        deskripsi: 'Akses internet cepat di semua area',
        gambar: 'https://source.unsplash.com/featured/?wifi'
      }
    ]);

    console.log('✅ Data dummy berhasil dimasukkan!');
    process.exit();
  } catch (err) {
    console.error('❌ Gagal memasukkan data:', err);
    process.exit(1);
  }
}
