pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REGISTRY = '795644302799.dkr.ecr.us-east-1.amazonaws.com'
        ECR_REPO = 'ecosmart-production'
        ECS_CLUSTER = 'ecosmart-production-cluster'
        ECS_SERVICE = 'ecosmart-production-service'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ABDON72/ecosmart-production-platform'
            }
        }
        
        stage('Login to ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 795644302799.dkr.ecr.us-east-1.amazonaws.com'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ecosmart-production .'
                sh 'docker tag ecosmart-production:latest 795644302799.dkr.ecr.us-east-1.amazonaws.com/ecosmart-production:latest'
            }
        }
        
        stage('Push to ECR') {
            steps {
                sh 'docker push 795644302799.dkr.ecr.us-east-1.amazonaws.com/ecosmart-production:latest'
            }
        }
        
        stage('Deploy to ECS') {
            steps {
                sh 'aws ecs update-service --cluster ecosmart-production-cluster --service ecosmart-production-service --force-new-deployment --region us-east-1'
            }
        }
    }
    
    post {
        success {
            echo 'EcoSmart Production deployed successfully! 🌿🚀'
        }
        failure {
            echo 'Deployment failed! ❌'
        }
    }
}
