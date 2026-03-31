pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = 'abdoulanounkou/my-jenkins-app'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing the Docker image...'
                sh '''
                    docker run --rm \
                    --entrypoint python \
                    ${IMAGE_NAME}:latest \
                    -c "from flask import Flask; print('Flask import successful')"
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing to Docker Hub...'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push ${IMAGE_NAME}:latest'
            }
        }
    }

    post {
        success {
            echo 'Image successfully built and pushed to Docker Hub!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}