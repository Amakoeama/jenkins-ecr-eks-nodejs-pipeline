# --- Jenkins - ECR - EKS Node.js CI/CD Pipeline ---

# --- Overview ---
This project implements a production-style CI/CD pipeline that automates the build and delivery of a Dockerized Node.js application using Jenkins and Amazon ECR, with infrastructure provisioned using Terraform.

The pipeline pulls source code from GitHub, builds a Docker image, authenticates to Amazon ECR using an IAM role attached to a Jenkins EC2 instance, and pushes versioned images to a private ECR repository.

This project follows real-world DevOps practices including Infrastructure as Code, least-privilege IAM, and immutable container artifacts.

---

# --- Architecture ---
High-level workflow:

1. Developer pushes code to GitHub
2. Jenkins pulls source code using SSH authentication
3. Jenkins builds the Docker image
4. Jenkins authenticates to Amazon ECR using IAM role
5. Docker image is tagged with the Jenkins build number
6. Image is pushed to Amazon ECR for downstream use (EKS)

### Infrastructure Provisioning (Terraform)

The Jenkins CI server infrastructure is provisioned using Terraform to ensure repeatable, auditable, and production-aligned deployment.

![Terraform Structure](screenshots/01-terraform-structure.png)

Terraform configuration is validated before deployment to prevent misconfiguration and ensure consistency across environments.

![Terraform Validate](screenshots/02-terraform-validate.png)

---

# --- Tech Stack ---
- Jenkins (CI/CD)
- Terraform (Infrastructure as Code)
- AWS (EC2, ECR, IAM)
- Docker (Containerization)
- Node.js (Application)
- GitHub (Source Control, SSH access)

---

# --- Project Structure ---
jenkins-ecr-eks-nodejs-pipeline/
├── app/ # Node.js application
├── docker/ # Dockerfile
├── terraform/
│ └── jenkins/
│ ├── provider.tf
│ ├── variables.tf
│ ├── security.tf
│ ├── iam.tf
│ ├── data.tf
│ ├── main.tf
│ ├── outputs.tf
│ ├── terraform.tfvars
│ └── user_data.sh
├── Jenkinsfile
├── screenshots/
└── README.md


---

# --- CI/CD Pipeline Flow ---
The Jenkins pipeline executes the following stages:

- **Checkout** – Pulls source code from GitHub
- **Build Docker Image** – Builds the Node.js Docker image
- **Authenticate to ECR** – Uses AWS CLI with EC2 IAM role
- **Tag & Push Image** – Pushes the image to Amazon ECR

Docker images are tagged using the Jenkins build number to ensure traceability.

---

# --- Jenkins Pipeline (Jenkinsfile) ---
The pipeline uses environment variables for region, repository name, and image tagging.

```groovy
IMAGE_TAG = "${BUILD_NUMBER}"
