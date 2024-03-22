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
        stage('Prompt for Action') {
            steps {
                script {
                    def userInput = input(
                        id: 'userInput',
                        message: 'Do you want to apply changes or destroy infrastructure?',
                        parameters: [
                            choice(choices: ['Apply', 'Destroy'], description: 'Choose action to perform')
                        ]
                    )
                    env.APPLY = (userInput == 'Apply') ? 'true' : 'false'
                    env.DESTROY = (userInput == 'Destroy') ? 'true' : 'false'
                }
            }
        }
        stage('Terraform Apply') {
            when {
                expression {
                    return env.APPLY == 'true'
                }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve -input=false tfplan'
                }
            }
        }
        stage('Terraform Destroy') {
            when {
                expression {
                    return env.DESTROY == 'true'
                }
            }
            steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
    }
  }
}
