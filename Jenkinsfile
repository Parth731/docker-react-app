pipeline {
    agent { docker { image 'docker' } }
    
    environment {
        DOCKER_CONFIG = "${env.WORKSPACE}/.docker"  // Set Docker config in workspace
        CI = 'true'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mkdir -p $DOCKER_CONFIG'  // Create the custom Docker config directory
                    sh 'docker build -t parth731/docker-react -f Dockerfile.dev .'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    sh 'docker run -e CI=true parth731/docker-react npm run test'
                }
            }
        }
    }
}
