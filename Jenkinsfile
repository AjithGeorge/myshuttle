import groovy.json.JsonSlurper

node {
  stage('init') {
    checkout scm
  }
  
  stage('build') {
    sh 'mvn clean package'
  }
  
}
