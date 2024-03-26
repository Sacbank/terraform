pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

   agent  any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "https://github.com/Sacbank/terraform.git"
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Apply') {
            steps {
               sh "terraform apply -input=false tfplan"
            }
        }
    }
  }
