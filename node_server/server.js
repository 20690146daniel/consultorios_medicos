const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const mongoUrl = "mongodb+srv://admin:admin1@consutorio.sisyumk.mongodb.net/consultoriomedico?retryWrites=true&w=majority&appName=consutorio";

mongoose.connect(mongoUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log('******CONECTADO A MONDONGO****');
}).catch(err => {
  console.error('#####ERROR EN MONDONGO###', err);
});

const userSchema = new mongoose.Schema({
  nombre: String,
  correo: String,
  contrasena: String
});

const User = mongoose.model('User', userSchema);

const pacienteSchema = new mongoose.Schema({
  nombre: String,
  edad: Number,
  historial: String
});

const Paciente = mongoose.model('Paciente', pacienteSchema);

app.post('/', async (req, res) => {
  const { correo, contrasena } = req.body;
  const user = await User.findOne({ correo, contrasena });
  if (user) {
    res.send({ message: 'Login successful' });
  } else {
    res.status(401).send({ message: 'Invalid credentials' });
  }
});


app.get('/pacientes', async (req, res) => {
  try {
    const pacientes = await Paciente.find({});
    res.status(200).json(pacientes);
  } catch (err) {
    res.status(500).send({ message: 'Error al obtener los datos de pacientes' });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
