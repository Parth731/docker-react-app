pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'parth731/learn-jenkins-docker-app'
        AWS_REGION = 'ap-south-1'
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
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'docker-react-travis-ci']]) {
                        sh '''
                            aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                            aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                            aws configure set region $AWS_REGION
                            
                            # Deploy the Docker image to Elastic Beanstalk
                            eb init $APP_NAME --region $AWS_REGION --platform "Docker"
                            eb use $ENV_NAME
                            eb deploy
                        '''
                    }
                }   
            }
        }

        stage('Deploy to Elastic Beanstalk') {
            steps {
                sh '''
                    # Example deployment command
                    eb init -p "Docker" my-app --region $AWS_REGION
                    eb create my-env
                    eb deploy
                '''
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
