require('dotenv').config();
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const Admin = require('./models/admin');

mongoose.connect(process.env.MONGODB_URI)
  .then(async () => {
    console.log('Connected to DB');
    await Admin.deleteMany({});

    const hashedPassword = await bcrypt.hash('admin123', 10);

    const admin = new Admin({
      email: 'admin@hotel.com',
      password: hashedPassword,
    });

    await admin.save();
    console.log('✅ Admin saved');
    mongoose.disconnect();
  })
  .catch(console.error);
