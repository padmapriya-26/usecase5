pipeline {  
    agent any  
    environment {  
        DOCKERHUB_CREDENTIALS = credentials('docker-creds')  
    }  
    stages {  
        stage('checkout') {  
            steps {  
                echo "*********** cloning the code **********"  
                sh 'rm -rf usecase5 || true'  
                sh 'git clone https://github.com/padmapriya-26/usecase5.git' 
            }  
        }   
        stage('Docker image build') {  
            steps {  
                echo "********** building is done ************"  
                dir('usecase5') {  
                    sh 'docker build -t padmapriya26/flaskimgg:v1 .'  
                }  
            }  
        }
        stage('Push to Docker Hub') {  
            steps {  
                sh """  
                docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}  
                docker push padmapriya26/flaskimgg:v1  
                """  
            }  
        }
        stage('vm creation using Terraform') {
            steps {
                echo "********** VM creation is done ************"
                dir('/var/lib/jenkins/workspace/usecase5') {
                    sh 'git pull origin main'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Ansible deployment') {
            steps {
                echo "********** Ansible deployment is done ************"
                dir('/var/lib/jenkins/workspace/usecase5') {
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /var/lib/jenkins/workspace/ip.txt playbook.yaml --private-key=/var/lib/jenkins/.ssh/id_ed25519 '
                }
            }
        }
    }  
}
