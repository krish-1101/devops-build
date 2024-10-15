pipeline {
    agent any 

    environment {
        DOCKER_CREDENTIALS_ID = 'krish011' // Your Docker Hub credentials ID
        GITHUB_CREDENTIALS_ID = 'krish-1101' // Your GitHub credentials ID
        DOCKER_IMAGE = 'krish011/my-react-app' // Docker image name
        TAG = 'latest' // Docker image tag
    }

    stages {
        // Checkout the code from your GitHub repository
        stage('Checkout Code') {
            steps {
                git branch: 'dev', credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/devops-build.git'
            }
        }

        // Build the React app (or another frontend app)
        stage('Build Frontend') {
            steps {
                script {
                    // Install dependencies and build the project (e.g., React)
                    sh 'npm install'
                    sh 'npm run build' // This will generate the build directory
                }
            }
        }
        
        // Verify that the build directory exists before Docker tries to copy it
        stage('Verify Build Directory') {
            steps {
                script {
                    // Check if the 'build' directory exists, and output the contents
                    sh 'ls -l build || echo "Build directory not found!"'
                }
            }
        }

        // Build the Docker image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile
                    customImage = docker.build("${DOCKER_IMAGE}:${TAG}")
                }
            }
        }

        // Push the Docker image to Docker Hub
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        customImage.push() // Push the built image to Docker Hub
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build and Push Successful!'
        }
        failure {
            echo 'Build Failed!'
        }
    }
}
