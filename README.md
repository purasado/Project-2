# Scoring Service

Simple FastAPI scoring service with /health and /predict.

## Structure
- app.py — FastAPI app
- Dockerfile — multi-stage, non-root, healthcheck
- k8s/ — Kubernetes manifests
- terraform/ — Terraform for ECR + CloudWatch + SNS
- Jenkinsfile — CI/CD pipeline to build, push, deploy

## Quick start (development)
1. Create virtualenv:
python -m venv venv
. venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload

2. Open http://localhost:8000/health and /predict

## Deploy overview
1. Use Terraform to create ECR, SNS and CloudWatch resources.
2. Run EKS cluster (eksctl recommended).
3. Push code to GitHub.
4. Run Jenkins (on EC2) to build image and deploy to EKS.

## Security notes
- Non-root user in container
- Secrets should be stored in AWS Secrets Manager or SSM (not in repo)
- Use HTTPS at LoadBalancer with ACM cert for production


