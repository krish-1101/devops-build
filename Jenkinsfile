pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        GITHUB_CREDENTIALS_ID = 'github-pat-credentials-id'
        DOCKER_IMAGE = 'krish011/my-react-app'
        TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'dev', credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/devops-build.git'
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    // Add npm or frontend build commands here
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE}:${TAG} .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: 'https://index.docker.io/v1/']) {
                        sh 'docker push ${DOCKER_IMAGE}:${TAG}'
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
