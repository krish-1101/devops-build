pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'krish011' // Your Docker Hub credentials ID
        GITHUB_CREDENTIALS_ID = 'krish-1101' // Your GitHub credentials ID
        DOCKER_IMAGE = 'krish011/my-react-app' // Docker image name
        TAG = 'latest' // Docker image tag
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from the GitHub repository
                git branch: 'dev', credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/your-repo.git'
            }
        }

        stage('Build Frontend') {
            agent {
                // Use a Node.js Docker image to run npm commands
                docker {
                    image 'node:14-alpine' // Choose a Node.js version based on your requirements
                    args '-v /var/lib/jenkins/workspace:/workspace' // Mount workspace into the container
                }
            }
            steps {
                script {
                    sh 'npm install' // Install dependencies
                    sh 'npm run build' // Run the build script
                }
            }
        }

        stage('Verify Build Directory') {
            steps {
                sh 'ls -l build || echo "Build directory not found!"'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def customImage = docker.build("${DOCKER_IMAGE}:${TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        customImage.push()
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
