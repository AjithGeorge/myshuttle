pipeline {
    agent any

    stages {
        stage('init') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build') {
            steps {
                    sh 'mvn clean package'
            }
        }
    }
}
