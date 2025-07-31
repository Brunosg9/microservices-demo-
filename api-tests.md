# Testes da API Backend

## 1. Health Check
```bash
curl -X GET "http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com/api/health" \
  -H "Content-Type: application/json"
```

## 2. Weather API - São Paulo (default)
```bash
curl -X GET "http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com/api/weather" \
  -H "Content-Type: application/json"
```

## 3. Weather API - Rio de Janeiro
```bash
curl -X GET "http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com/api/weather?city=rio%20de%20janeiro" \
  -H "Content-Type: application/json"
```

## 4. Weather API - Brasília
```bash
curl -X GET "http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com/api/weather?city=brasília" \
  -H "Content-Type: application/json"
```

## 5. Weather API - Salvador
```bash
curl -X GET "http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com/api/weather?city=salvador" \
  -H "Content-Type: application/json"
```

## Para usar no Postman:

**Base URL:** `http://k8s-default-appingre-4d432af666-1060271799.us-east-1.elb.amazonaws.com`

### Endpoints:
1. **GET** `/api/health` - Health check
2. **GET** `/api/weather` - Weather para São Paulo
3. **GET** `/api/weather?city=rio de janeiro` - Weather para Rio
4. **GET** `/api/weather?city=brasília` - Weather para Brasília
5. **GET** `/api/weather?city=salvador` - Weather para Salvador