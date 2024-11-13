## general information

- `docker build -f Dockerfile.dev .`

```js
 "scripts": {
    "start": "WATCHPACK_POLLING=true react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
```

- While using react-scripts 5.0.1, CHOKIDAR_USEPOLLING didn't function as expected but setting WATCHPACK_POLLING = True did the trick.

- `docker run -p 4000:3000 -v /react-dev-app/node_modules -v ${PWD}:/react-dev-app 636af2fa9cea57f02e84e131d50ecdb0303d24281c5814fcdb2b4c4865db5065`

## jenkins pipeline

- Automatic build creation (ch 90)

  ```groovy
  pipeline {
  agent any

      environment {
          // Replace with your Docker Hub username and repo name
          DOCKER_IMAGE = 'parth731/learn-jenkins-docker-app'
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
                      sh 'docker run -e CI=true $DOCKER_IMAGE:$DOCKER_TAG npm run test'
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
                      sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
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
  ```
