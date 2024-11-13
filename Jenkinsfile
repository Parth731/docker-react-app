pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'parth731/learn-jenkins-docker-app'
        AWS_DEFAULT_REGION = 'ap-south-1'
        APP_NAME = 'docker'
        ENV_NAME = 'docker-env'
        BUCKET_NAME = 'elasticbeanstalk-ap-south-1-597081897916'
        CI = 'true'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using Dockerfile.dev
                    sh 'docker build -t $DOCKER_IMAGE -f Dockerfile.dev .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests inside the Docker container
                    sh 'docker run -e CI=true $DOCKER_IMAGE npm run test -- --coverage'
                }
            }
        }

        stage('Configure AWS Credentials') {
            steps {
                script {
                    // Deploy to AWS Elastic Beanstalk using AWS CLI
                   withCredentials([usernamePassword(credentialsId: 'docker-react-travis-ci-id', passwordVariable: 'AWS_ACCESS_KEY_ID', usernameVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                            aws --version
                            aws s3 ls
                        '''
                    }
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
