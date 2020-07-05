pipeline {
    agent any
    stages {
        stage('Build') {
            steps {

                sh 'npm install'
                sh 'zip -r lambda-package.zip * -x terraform/ Jenkinsfile'
                sh 'aws s3 cp lambda-package.zip s3://lambdademogh/v1.1.0/lambda3.zip'
            }
        }
        stage ('Deploy') {
            steps {
           dir('terraform'){
               
              sh 'terraform init'
              sh 'terraform apply -auto-approve'
          }
         
         }
        }
    }
}
