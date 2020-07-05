
pipeline {
    agent any
    stages {
        stage('init') {
    checkout scm
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
          stage('build') {
    sh 'mvn clean package'
  }
    }
}
