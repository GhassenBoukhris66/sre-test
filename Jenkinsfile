pipeline {
    agent any
    stages {
        stage('Build') { 
            steps {
                sh 'cat /home/cloud_user/hello.txt'
                sh 'pwd'
                sh 'whoami'
                npm install
            }
        }
    }
}
