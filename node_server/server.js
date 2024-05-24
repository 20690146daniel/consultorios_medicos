const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const mongoUrl = "mongodb+srv://admin:admin1@consutorio.sisyumk.mongodb.net/admin?retryWrites=true&w=majority&appName=consutorio";

mongoose.connect(mongoUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log('Connected to MongoDB');
}).catch(err => {
  console.error('Error connecting to MongoDB', err);
});

const userSchema = new mongoose.Schema({
  nombre: String,
  correo: String,
  contrasena: String
});

const User = mongoose.model('User', userSchema);

app.post('/login', async (req, res) => {
  const { correo, contrasena } = req.body;
  const user = await User.findOne({ correo, contrasena });
  if (user) {
    res.send({ message: 'Login successful' });
  } else {
    res.status(401).send({ message: 'Invalid credentials' });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
