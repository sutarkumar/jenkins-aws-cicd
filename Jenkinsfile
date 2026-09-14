pipeline {

    agent any

    environment {
        PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Node and npm') {
            steps {
                sh 'node --version'
                sh 'npm --version'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'cd app && npm ci'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'cd app && npm test'
            }
        }

        stage('Deploy to EC2') {
            steps {
                withCredentials([file(credentialsId: 'ec2-deploy-key', variable: 'SSH_KEY')]) {
                    sh '''
                        chmod 600 "$SSH_KEY"

                        ssh -i "$SSH_KEY" \
                            -o StrictHostKeyChecking=no \
                            ec2-user@15.252.240.238 '
                                cd ~/jenkins-aws-cicd &&
                                git pull origin main &&
                                cd app &&
                                npm ci &&
                                pm2 restart jenkins-cicd-app || pm2 start server.js --name jenkins-cicd-app
                            '
                    '''
                }
            }
        }
    }

    post {

        success {
            echo 'CI/CD Pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD Pipeline failed!'
        }
    }
}
