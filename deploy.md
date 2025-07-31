# Deploy Guide

## 1. Build e Push das Imagens

```bash
./build.sh
```

## 2. Atualizar Manifestos K8s

Substitua `<account-id>` e `<region>` nos arquivos:
- `k8s/frontend-deployment.yaml`
- `k8s/backend-deployment.yaml`

## 3. Deploy via Kustomize

```bash
# Deploy direto
kubectl apply -k k8s/

# Ou via ArgoCD
kubectl apply -f argocd/application.yaml
```

## 4. Verificar Deploy

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

## URLs

- Frontend: http://app.example.com
- Backend API: http://app.example.com/api/health