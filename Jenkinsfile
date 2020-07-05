import groovy.json.JsonSlurper
node {
  stage('init') {
    checkout scm
  }
  
  stage('build') {
    sh 'mvn clean package'
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
}
