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
                git branch: 'dev', credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/devops-build.git'
            }
        }
        
        stage('Build Frontend') {
            steps {
                script {
                    // Build the React app
                    sh 'npm install'
                    sh 'npm run build' // Ensure this generates the /build directory
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    def customImage = docker.build("${DOCKER_IMAGE}:${TAG}", "--build-arg PORT=90 .") // Pass build argument if needed
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        customImage.push() // Push the Docker image
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
