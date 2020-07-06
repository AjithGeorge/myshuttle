import groovy.json.JsonSlurper

def getFtpPublishProfile(def publishProfilesJson) {
  def pubProfiles = new JsonSlurper().parseText(publishProfilesJson)
  for (p in pubProfiles)
    if (p['publishMethod'] == 'FTP')
      return [url: p.publishUrl, username: p.userName, password: p.userPWD]
}

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
        stage('deploy') {
            steps {
                def resourceGroup = 'myShuttleRG2' 
                def webAppName = 'MyShuttleApp2021'
                // login Azure
                withCredentials([azureServicePrincipal('jenkinsServicePrincipal')]) {
                    sh '''
                        az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
                        az account set -s $AZURE_SUBSCRIPTION_ID
                    '''
                }
                // get publish settings
                def pubProfilesJson = sh script: "az webapp deployment list-publishing-profiles -g $resourceGroup -n $webAppName", returnStdout: true
                def ftpProfile = getFtpPublishProfile pubProfilesJson
                // upload package
                sh "curl -T target/myshuttledev.war $ftpProfile.url/webapps/ROOT.war -u '$ftpProfile.username:$ftpProfile.password'"
                // log out
                sh 'az logout'
            }
        }
    }
}
