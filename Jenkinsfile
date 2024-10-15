pipeline {
    agent any

    tools {
        nodejs 'NodeJS 14'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'dev', credentialsId: 'GITHUB_CREDENTIALS_ID', url: 'https://github.com/krish-1101/devops-build.git'
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    sh 'npm install' // Install dependencies
                    sh 'npm run build' // Build the project using the script in package.json
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
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
