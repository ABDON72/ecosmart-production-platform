pipeline {

    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/ABDON72/ecosmart-production-platform.git'
            }
        }


        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ecosmart-website ./website'
            }
        }


        stage('Run Container') {
            steps {
                sh '''
                docker stop ecosmart-app || true
                docker rm ecosmart-app || true
                docker run -d -p 8080:80 --name ecosmart-app ecosmart-website
                '''
            }
        }

    }
}
