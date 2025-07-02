require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(morgan('dev'));

app.use(cors());
app.use(express.json());

mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('MongoDB terkoneksi'))
  .catch(err => console.error(err));

// ROUTES
app.use('/api/kamar', require('./routes/kamarRoutes'));
app.use('/api/fasilitas', require('./routes/fasilitasRoutes'));
app.use('/api/reservasi', require('./routes/reservasiRoutes'));

app.listen(PORT, '0.0.0.0', () => console.log(`Server jalan di http://0.0.0.0:${PORT}`));


app.use(morgan('dev'));

app.get('/', (req, res) => {
  res.send('API Hotel Jalan Cuy 🚀');
});
app.use((req, res, next) => {
  res.status(404).json({ success: false, message: 'Endpoint tidak ditemukan' });
});
