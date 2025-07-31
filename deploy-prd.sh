#!/bin/bash

set -e

echo "🚀 Iniciando deploy no EKS cluster de produção..."

# Obter informações da conta AWS
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=$(aws configure get region)
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

echo "📋 Account ID: $ACCOUNT_ID"
echo "📋 Region: $REGION"

# Verificar se está conectado ao cluster correto
CURRENT_CONTEXT=$(kubectl config current-context)
echo "📋 Current context: $CURRENT_CONTEXT"

if [[ ! "$CURRENT_CONTEXT" == *"eks-cluster-prd"* ]]; then
    echo "⚠️  Aviso: O contexto atual não parece ser o cluster de produção"
    read -p "Deseja continuar? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 1. Build e push das imagens
echo "🔨 Building e fazendo push das imagens..."
./build.sh

# 2. Atualizar manifestos com as informações corretas
echo "📝 Atualizando manifestos K8s..."
sed -i "s/<account-id>/$ACCOUNT_ID/g" k8s/*.yaml
sed -i "s/<region>/$REGION/g" k8s/*.yaml

# 3. Deploy via kustomize
echo "🚀 Fazendo deploy no cluster..."
kubectl apply -k k8s/

# 4. Aguardar rollout
echo "⏳ Aguardando rollout dos deployments..."
kubectl rollout status deployment/frontend -n default --timeout=300s
kubectl rollout status deployment/backend -n default --timeout=300s

# 5. Verificar status
echo "✅ Verificando status do deploy..."
kubectl get pods -l app.kubernetes.io/name=microservices-demo
kubectl get svc -l app.kubernetes.io/name=microservices-demo
kubectl get ingress

echo "🎉 Deploy concluído com sucesso!"
echo "📱 Acesse a aplicação em: http://app.example.com"