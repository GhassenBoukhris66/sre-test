pipeline {
    agent any
    stages {
        stage('Build') {
            steps {

                sh 'npm install'
                sh 'zip -r lambda-package.zip *'
            }
        }
        stage ('Deploy') {
           sh 'terraform init'
           sh 'terraform apply -auto-approve'
         }
    }
}
