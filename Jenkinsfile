pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'your_git_repository_url'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-java-app')
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    docker.image('my-java-app').run('-d -p 8080:8080')
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}

