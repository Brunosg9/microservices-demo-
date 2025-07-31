const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Mock weather data
const weatherData = {
  'são paulo': { temperature: 23, description: 'Parcialmente nublado', humidity: 65 },
  'rio de janeiro': { temperature: 28, description: 'Ensolarado', humidity: 70 },
  'brasília': { temperature: 25, description: 'Céu limpo', humidity: 45 },
  'salvador': { temperature: 30, description: 'Ensolarado', humidity: 75 },
  'fortaleza': { temperature: 32, description: 'Muito quente', humidity: 80 }
};

app.get('/api/health', (req, res) => {
  console.log(`[${new Date().toISOString()}] Health check requested`);
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    service: 'weather-api'
  });
});

app.get('/api/weather', (req, res) => {
  const city = req.query.city?.toLowerCase() || 'são paulo';
  console.log(`[${new Date().toISOString()}] Weather requested for city: ${city}`);
  
  const weather = weatherData[city] || {
    temperature: Math.floor(Math.random() * 15) + 20,
    description: 'Dados não disponíveis',
    humidity: Math.floor(Math.random() * 40) + 40
  };

  const response = {
    city: req.query.city || 'São Paulo',
    ...weather,
    timestamp: new Date().toISOString()
  };
  
  console.log(`[${new Date().toISOString()}] Returning weather data:`, response);
  res.json(response);
});

app.listen(PORT, () => {
  console.log(`Weather API running on port ${PORT}`);
});