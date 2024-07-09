pipeline {
    agent any
    
    tools {
        jdk 'jdk'
        maven 'maven'
    }

    environment {
        dynamicImageName = "helloapp:${env.BUILD_NUMBER}"
        DOCKER_REGISTRY = 'roshandocker11'
        IMAGE_TAG = 'latest'
        SCANNER_HOME=tool 'sonar'
    }

    stages {
        stage('Git Checkout -feature') {
            steps {
                git branch: 'feature', changelog: false, poll: false, url: 'https://github.com/roshan-etc/Helloapp.git'
            }
        }
        
        stage('Compile SourceCode') {
            steps {
                sh "mvn clean compile"
            }
        }
        
        stage('Sonar') {
            steps {
                withSonarQubeEnv(sonar') {
                    sh ''' 
                        mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=helloapp \
                        -Dsonar.host.url=http://13.201.125.20:9000 \
                        -Dsonar.login=sqp_ca918dd65416298bf0d819b628e687e73e64cfd4
                    '''
                }
            }
        }

        stage('Build SourceCode') {
            steps {
                sh "mvn package"
            }
        }
        
        stage('Build DockerImage') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'ed37363e-71c9-4ddb-bb8e-4b196c0943d8', toolName: 'docker') {
                        sh "docker build -t ${dynamicImageName} ."
                    }
                }
            }
        }
        
        stage('Tag DockerImage') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'ed37363e-71c9-4ddb-bb8e-4b196c0943d8', toolName: 'docker') {
                        def imageName = "helloapp"
                        def fullTag = "${DOCKER_REGISTRY}/${imageName}:${env.BUILD_NUMBER}-${IMAGE_TAG}"
                        sh "docker tag ${dynamicImageName} ${fullTag}"
                    }
                }
            }
        }
        
        stage('Push DockerImage-Dockerhub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'ed37363e-71c9-4ddb-bb8e-4b196c0943d8', toolName: 'docker') {
                        def imageName = "helloapp"
                        def fullTag = "${DOCKER_REGISTRY}/${imageName}:${env.BUILD_NUMBER}-${IMAGE_TAG}"
                        sh "docker push ${fullTag}"
                    }
                }
            }
        }
        
        stage('Approval stage') {
            steps {
                script {
                    // Wait for human approval before proceeding
                    input message: 'Do you approve the deployment?', ok: 'Approve'
                }
            }
        }
        
        
        stage('Deployment') {
            steps {
                sh "docker compose up -d"
            }
        }
    }
}
