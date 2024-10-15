pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Your Docker Hub credentials ID
        GITHUB_CREDENTIALS_ID = 'github-pat-credentials-id' // Update with your GitHub PAT credentials ID
        DOCKER_IMAGE = 'krish011/my-react-app' // Docker image name
        TAG = 'latest' // Docker image tag
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from the GitHub repository using PAT
                git branch: 'dev', credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/devops-build.git'
            }
        }
        
        stage('Build Frontend') {
            steps {
                script {
                    // Frontend build steps, e.g., npm install and build
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_IMAGE}:${TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: 'https://index.docker.io/v1/']) {
                        // Push the Docker image
                        docker.image("${DOCKER_IMAGE}:${TAG}").push()
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
