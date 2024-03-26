pipeline {
    parameters {
        choice(
            name: 'action',
            choices: ['apply', 'destroy'],
            description: 'Select action: apply or destroy'
        )
    }
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
		stage('Apply or Destroy') {
            when {
                expression { params.action == 'apply' || params.action == 'destroy' }
            }
            steps {
                script {
                    def command = "apply"
                    if (params.action == 'destroy') {
                        command = "destroy"
                    }
                    sh "terraform $command -auto-approve"
                }
            }
        }	
       }
    }
