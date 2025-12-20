def AWS_ACCOUNT_ID = sh(
    script: "aws sts get-caller-identity --query Account --output text",
    returnStdout: true
).trim()

pipeline {
    agent any

    environment {
        AWS_REGION    = "us-east-1"
        ECR_REPO_NAME = "nodejs-demo-app"
        IMAGE_TAG     = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build \
                    -t ${ECR_REPO_NAME}:${IMAGE_TAG} \
                    -f docker/Dockerfile .
                '''
            }
        }

        stage('Authenticate to ECR') {
            steps {
                sh '''
                  aws ecr get-login-password --region ${AWS_REGION} \
                  | docker login \
                    --username AWS \
                    --password-stdin \
                    ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                sh '''
                  docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} \
                    ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}

                  docker push \
                    ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo "Docker image pushed successfully to Amazon ECR"
        }
        failure {
            echo "Pipeline failed — check logs"
        }
    }
}
