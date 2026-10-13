Step 1 — Configure AWS and EKS

export AWS_REGION=ap-south-1
export EKS_CLUSTER=my-eks-cluster
export ECR_REPO=gitops-demo

aws sts get-caller-identity

aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$EKS_CLUSTER"

kubectl get nodes

Step 2 — Create your ECR repository

aws ecr create-repository \
  --repository-name "$ECR_REPO" \
  --region "$AWS_REGION" \
  --image-scanning-configuration scanOnPush=true


Step 3 — Retrieve your registry address:

export ACCOUNT_ID=$(aws sts get-caller-identity \
  --query Account --output text)

export ECR_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"

echo "$ECR_URI"

Step 4 - Update newName with ECR Repo

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - namespace.yaml
  - deployment.yaml
  - service.yaml

images:
  - name: IMAGE_PLACEHOLDER
    newName: 123456789012.dkr.ecr.ap-south-1.amazonaws.com/gitops-demo
    newTag: initial

Step 5- Push your code

git init
git branch -M main
git add .
git commit -m "Initial EKS GitOps application"

git remote add origin \
  https://github.com/YOUR_ORG/eks-gitops-demo.git

git push -u origin main

push some changes dsjdsdssdk

