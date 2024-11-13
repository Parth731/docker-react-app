pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY = credentials('aws-access-key')  // Replace with your Jenkins credential ID for AWS access key
        AWS_SECRET_KEY = credentials('aws-secret-key')  // Replace with your Jenkins credential ID for AWS secret key
        DOCKER_IMAGE = 'parth731/learn-jenkins-docker-app'     // Docker image name
        S3_BUCKET = 'elasticbeanstalk-ap-south-1-597081897916' // S3 bucket name
        APP_NAME = 'docker'
        ENV_NAME = 'docker-env'
        REGION = 'ap-south-1'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with Dockerfile.dev
                    sh 'docker build -t $DOCKER_IMAGE -f Dockerfile.dev .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests in Docker container
                    sh 'docker run -e CI=true $DOCKER_IMAGE npm run test -- --watchAll=false'
                }
            }
        }

        stage('Deploy to Elastic Beanstalk') {
            steps {
                script {
                    // Configure AWS CLI

                    sh 'aws --version'
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY
                        aws configure set aws_secret_access_key $AWS_SECRET_KEY
                        aws configure set default.region $REGION
                    '''

                    // Create a new Dockerrun.aws.json file for Elastic Beanstalk deployment
                    sh '''
                        echo '{
                            "AWSEBDockerrunVersion": "1",
                            "Image": {
                                "Name": "$DOCKER_IMAGE",
                                "Update": "true"
                            },
                            "Ports": [{
                                "ContainerPort": "80"
                            }]
                        }' > Dockerrun.aws.json
                    '''

                    // Zip the Dockerrun file for upload
                    sh 'zip -r $APP_NAME.zip Dockerrun.aws.json'

                    // Upload the zip to S3
                    sh '''
                        aws s3 cp $APP_NAME.zip s3://$S3_BUCKET/$APP_NAME.zip
                    '''

                    // Deploy the application to Elastic Beanstalk
                    sh '''
                        aws elasticbeanstalk create-application-version --application-name $APP_NAME --version-label jenkins-deploy --source-bundle S3Bucket=$S3_BUCKET,S3Key=$APP_NAME.zip
                        aws elasticbeanstalk update-environment --application-name $APP_NAME --environment-name $ENV_NAME --version-label jenkins-deploy
                    '''
                }
            }
        }
    }
}
