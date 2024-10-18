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
