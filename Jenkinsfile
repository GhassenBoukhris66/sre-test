pipeline {
    agent any
    stages {
        stage('Build') {
            steps {

                sh 'npm install'
                sh 'zip -r lambda-package.zip app.js node_modules/ package.json package-lock.json parser.js'
                sh 'aws s3 cp lambda-package.zip s3://s3-bcuket/s3-key'
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
