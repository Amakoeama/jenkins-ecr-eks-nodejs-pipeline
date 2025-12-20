pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
    ECR_REPO   = "648056969700.dkr.ecr.us-east-1.amazonaws.com/nodejs-demo-app"
    IMAGE_TAG  = "${BUILD_NUMBER}"
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
          docker build -t nodejs-demo-app:${IMAGE_TAG} -f docker/Dockerfile .
        '''
      }
    }

    stage('Login to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION \
          | docker login --username AWS --password-stdin $ECR_REPO
        '''
      }
    }

    stage('Tag & Push Image') {
      steps {
        sh '''
          docker tag nodejs-demo-app:${IMAGE_TAG} $ECR_REPO:${IMAGE_TAG}
          docker push $ECR_REPO:${IMAGE_TAG}
        '''
      }
    }
  }
}
