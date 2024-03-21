pipeline {
    agent any
    
    environment {
        TF_WORKING_DIR = "terraform" // Set the directory containing Terraform files
    }
    
    stages {
        stage('Fetch Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Sacbank/terraform.git'
            }
        }
        
        stage('Setup Terraform') {
            steps {
                script {
                    // Download and install the latest version of Terraform
                    def tfHome = tool 'Terraform'
                    env.PATH = "${tfHome}/bin:${env.PATH}"
                    sh 'terraform --version'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    // Initialize and execute terraform plan
                    dir("${TF_WORKING_DIR}") {
                        sh 'terraform init'
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan
                    dir("${TF_WORKING_DIR}") {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Clean up steps
            script {
                // Backup Terraform state to prevent accidental destruction of resources
                dir("${TF_WORKING_DIR}") {
                    sh 'terraform state pull > terraform.tfstate.backup'
                }
            }
        }
    }
}
