pipeline{
    agent any
    tools{ 
        maven 'Maven 3.9.8'
    }
    stages{
        stage("git clone"){
            steps{
                git branch: 'master', credentialsId: 'git-access', url: 'https://github.com/saraswathi-surnoi/demo-fusion.git'
            }
        }
        stage("maven build"){
            steps {
              sh 'mvn -X clean package'
            }
        }        