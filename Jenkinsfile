pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'parth731/learn-jenkins-docker-app' // Replace with your Docker Hub username and repo name
        DOCKER_TAG = 'latest'
        CI = 'true'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using Dockerfile.dev
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG -f Dockerfile.dev .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests inside the Docker container
                    sh 'docker run -e CI=true $DOCKER_IMAGE:$DOCKER_TAG npm run test -- --coverage'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    // sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh 'echo Dang@3107 | docker login -u parth731 --password-stdin'
                    // Push the Docker image to Docker Hub
                    // sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker containers and images to free space
            sh 'docker system prune -f'
        }
    }
}
