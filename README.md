# Flask + MySQL Deployment to Amazon EKS with ECR Integration

This project demonstrates deploying a **Flask** application connected to a **MySQL** database on **Amazon EKS**, with container images stored in **Amazon ECR** and persistent storage managed via the AWS EBS CSI Driver.

---

## **Prerequisites**

- AWS Account with IAM permissions for EKS, ECR, EC2, and S3
- `kubectl` and `eksctl` installed
- Amazon Cloud9
- S3 bucket for hosting background images

---

## **Deployment Steps**

### **1. Authenticate to Amazon ECR**
```bash
mkdir -p ~/.aws
nano ~/.aws/credentials
# Add your AWS credentials
```

---

### **2. Build Docker Images**
```bash
docker build -t mysql -f Dockerfile_mysql .
docker build -t flask-app:latest .
```

---

### **3. Create Docker Network**
```bash
docker network create <network_name>
```

---

### **4. Run MySQL Container**
```bash
docker run -d --name mysql-db   --network <network_name>   -e MYSQL_ROOT_PASSWORD=password   mysql
```

---

### **5. Run Flask App Container**
```bash
docker run -d --name flask-app   --network clo-net   -p 8080:81   -e DBHOST=mysql-db   -e DBUSER=root   -e DBPWD=password   -e DATABASE=employees   -e DBPORT=3306   -e STUDENT_NAME="Ashmita & Pujan"   -e BG_IMAGE_URL="s3_url"   -e AWS_ACCESS_KEY_ID=<your-access-key>   -e AWS_SECRET_ACCESS_KEY=<your-secret-key>   -e AWS_SESSION_TOKEN=<your-session-token>   -e AWS_DEFAULT_REGION=us-east-1   flask-app:latest
```

---


### **6. Access Application Locally**
```bash
curl http://localhost:8080
```

---

### **7. Create EKS Cluster**
```bash
eksctl create cluster -f eks_config.yaml
```

---

### **8. Create Kubernetes Namespace**
```bash
kubectl create namespace <namespace_name>
```

---

### **9. Deploy Resources to EKS**
```bash
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/secret.yaml
kubectl apply -f manifests/pvc.yaml
kubectl apply -f manifests/mysql-service.yaml
kubectl apply -f manifests/mysql-deployment.yaml
kubectl apply -f manifests/flask-service.yaml
kubectl apply -f manifests/flask-deployment.yaml
```

---

### **10. Access the App**
```bash
kubectl get svc flask-service -n <namespace>
# Open the EXTERNAL-IP in your browser


