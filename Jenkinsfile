pipeline {
    agent any
    stages {
        stage('Build') {
            steps {

                sh 'npm install'
                sh 'zip -r lambda-package.zip * -x terraform'
                sh 's3 cp lambda-package.zip s3://lambdademogh/v1.1.0/lambda3.zip'
            }
        }
        stage ('Deploy') {
           sh 'terraform init'
           sh 'terraform apply -auto-approve'
         }
    }
}
