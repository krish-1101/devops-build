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
                    // Install dependencies
                    sh 'npm install'

                    // Ensure the public directory and index.html exist
                    sh '''
                    if [ ! -d "public" ]; then
                        echo "Creating public directory."
                        mkdir public
                    fi
                    echo "<!DOCTYPE html><html><head><title>Dummy</title></head><body></body></html>" > public/index.html
                    '''

                    // Build the project
                    sh 'npm run build'
                }
            }
        }
    }
}
