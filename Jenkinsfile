pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "hhgsharish/helloworld-app"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/hhgsharish/hello-world-war.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh 'docker run -d --name helloworld -p 8090:8080 $DOCKER_IMAGE'
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
