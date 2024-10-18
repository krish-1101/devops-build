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
                sh 'npm install'
                    sh 'echo "<!DOCTYPE html><html><head><title>Dummy</title></head><body></body></html>" > public/index.html'
                    sh 'npm run build'
                    sh '''
                    if [ ! -d "public" ]; then
                        echo "Creating public directory."
                        mkdir public
                    fi
                    '''
                    sh 'npm run build || true'
                    sh 'npm install'
                    sh 'echo "<!DOCTYPE html><html><head><title>Dummy</title></head><body></body></html>" > public/index.html'
                    sh 'npm run build'
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
