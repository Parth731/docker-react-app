pipeline {
    agent { docker { image 'docker' } }
    
    environment {
        CI = 'true'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'sudo docker build -t parth731/learn-jenkins-docker-app -f Dockerfile.dev .'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    sh 'sudo docker run -e CI=true parth731/learn-jenkins-docker-app npm run test'
                }
            }
        }
    }
}
