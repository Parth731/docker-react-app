pipeline {
    agent { docker { image 'docker' } } // Use a Docker-enabled Jenkins agent
    
    environment {
        CI = 'true' // Set CI environment variable as in Travis
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t parth731/docker-react -f Dockerfile.dev .'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Run tests in Docker with CI environment variable set
                    sh 'docker run -e CI=true parth731/docker-react npm run test'
                }
            }
        }
    }
}
