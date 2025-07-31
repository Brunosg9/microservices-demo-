#!/bin/bash

echo "🚀 Iniciando aplicação local..."

# Backend
echo "📡 Iniciando backend..."
cd backend && npm install && npm start &
BACKEND_PID=$!

# Aguardar backend iniciar
sleep 3

# Frontend
echo "🌐 Iniciando frontend..."
cd ../frontend && npm install && npm start &
FRONTEND_PID=$!

echo "✅ Aplicação rodando:"
echo "   Frontend: http://localhost:3000"
echo "   Backend:  http://localhost:3001/api/health"
echo ""
echo "Pressione Ctrl+C para parar"

# Aguardar interrupção
trap "kill $BACKEND_PID $FRONTEND_PID; exit" INT
wait