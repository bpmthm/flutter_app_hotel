require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// Koneksi ke MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('MongoDB terkoneksi'))
  .catch(err => console.error(err));

// Routes
app.use('/api/kamar', require('./routes/kamarRoutes'));
app.use('/api/fasilitas', require('./routes/fasilitasRoutes'));
app.use('/api/reservasi', require('./routes/reservasiRoutes'));
app.use('/api/admin', require('./routes/adminRoutes')); // Ini udah bener

// Root route
app.get('/', (req, res) => {
  res.send('API Hotel Jalan Cuy 🚀');
});

// Handler jika endpoint tidak ditemukan
app.use((req, res, next) => {
  res.status(404).json({ success: false, message: 'Endpoint tidak ditemukan' });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server jalan di http://0.0.0.0:${PORT}`);
});
