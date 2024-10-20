pipeline {
    agent any 

    environment {
        GITHUB_CREDENTIALS_ID = 'krish-1101'
        DOCKER_IMAGE_DEV = 'krish011/dev'
        DOCKER_IMAGE_PROD = 'krish011/prod'
        TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: env.BRANCH_NAME, credentialsId: GITHUB_CREDENTIALS_ID, url: 'https://github.com/krish-1101/devops-build.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    customImage = docker.build("${DOCKER_IMAGE_DEV}:${TAG}") // Build Docker image for dev
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        // Push to dev repo
                        docker.withRegistry('https://index.docker.io/v1/', 'krish011') {
                            customImage.push() // Push to dev
                        }
                    } else if (env.BRANCH_NAME == 'master') {
                        // Push to prod repo
                        customImage.tag("${DOCKER_IMAGE_PROD}:${TAG}") // Tag for prod
                        docker.withRegistry('https://index.docker.io/v1/', 'krish011') {
                            customImage.push("${DOCKER_IMAGE_PROD}:${TAG}") // Push to prod
                        }
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
