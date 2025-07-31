import React, { useState, useEffect } from 'react';

function App() {
  const [weather, setWeather] = useState(null);
  const [city, setCity] = useState('São Paulo');
  const [loading, setLoading] = useState(false);

  const fetchWeather = async () => {
    setLoading(true);
    try {
      const res = await fetch(`/api/weather?city=${city}`);
      const data = await res.json();
      setWeather(data);
    } catch (err) {
      console.error(err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchWeather();
  }, []);

  return (
    <div style={{ padding: '40px', textAlign: 'center', fontFamily: 'Arial' }}>
      <h1>🌤️ App do Tempo</h1>
      
      <div style={{ margin: '20px 0' }}>
        <input 
          value={city}
          onChange={(e) => setCity(e.target.value)}
          placeholder="Digite a cidade"
          style={{ padding: '10px', marginRight: '10px', fontSize: '16px' }}
        />
        <button 
          onClick={fetchWeather}
          disabled={loading}
          style={{ padding: '10px 20px', fontSize: '16px', cursor: 'pointer' }}
        >
          {loading ? 'Carregando...' : 'Buscar'}
        </button>
      </div>

      {weather && (
        <div style={{ 
          background: '#f0f8ff', 
          padding: '30px', 
          borderRadius: '10px',
          maxWidth: '400px',
          margin: '0 auto'
        }}>
          <h2>{weather.city}</h2>
          <div style={{ fontSize: '48px', margin: '20px 0' }}>
            {weather.temperature}°C
          </div>
          <p style={{ fontSize: '18px' }}>{weather.description}</p>
          <p>Umidade: {weather.humidity}%</p>
        </div>
      )}
    </div>
  );
}

export default App;