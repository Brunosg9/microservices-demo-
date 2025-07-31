# 🌤️ Weather App - Microservices Demo

Aplicação de consulta de tempo com arquitetura de microserviços usando React (frontend) e Node.js (backend), executando em cluster Amazon EKS.

## 🏗️ Arquitetura de Microserviços

Esta aplicação demonstra uma arquitetura de microserviços com dois serviços independentes:

- **Frontend Service**: Interface React responsiva que consome a API
- **Backend Service**: API REST Node.js/Express para dados meteorológicos
- **Containerização**: Cada serviço em container Docker isolado
- **Orquestração**: Kubernetes no Amazon EKS
- **CI/CD**: ArgoCD para deploy automatizado

### Benefícios da Arquitetura:
- Escalabilidade independente de cada serviço
- Deploy e atualizações isoladas
- Tolerância a falhas
- Tecnologias específicas por serviço

## 🚀 Execução Local

### Docker Compose (Recomendado)
```bash
docker-compose up --build
```
- Frontend: http://localhost:3000
- Backend: http://localhost:3001

### Execução Manual
```bash
# Backend
cd backend
npm install
npm start

# Frontend
cd frontend
npm install
npm start
```

## 📡 API Endpoints

- `GET /api/health` - Status da API
- `GET /api/weather?city=<cidade>` - Dados meteorológicos

## ☁️ Deploy no Amazon EKS

### Pré-requisitos
- Cluster EKS configurado
- kubectl configurado para o cluster
- AWS Load Balancer Controller instalado

### Deploy
```bash
# Deploy dos microserviços
kubectl apply -k k8s/

# Verificar status dos pods
kubectl get pods

# Obter URL do Load Balancer
kubectl get ingress
```

## 🛠️ Tecnologias

**Frontend:**
- React 18
- JavaScript ES6+

**Backend:**
- Node.js
- Express
- CORS

**DevOps:**
- Docker
- Amazon EKS (Kubernetes)
- AWS Load Balancer Controller
- ArgoCD
- Nginx
