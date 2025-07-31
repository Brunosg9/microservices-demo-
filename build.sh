#!/bin/bash

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=$(aws configure get region)
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

# Login ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URI

# Criar repositórios se não existirem
aws ecr describe-repositories --repository-names frontend 2>/dev/null || aws ecr create-repository --repository-name frontend
aws ecr describe-repositories --repository-names backend 2>/dev/null || aws ecr create-repository --repository-name backend

# Build e push frontend
docker build -t frontend ./frontend
docker tag frontend:latest $ECR_URI/frontend:latest
docker push $ECR_URI/frontend:latest

# Build e push backend
docker build -t backend ./backend
docker tag backend:latest $ECR_URI/backend:latest
docker push $ECR_URI/backend:latest

echo "Images pushed to ECR successfully!"