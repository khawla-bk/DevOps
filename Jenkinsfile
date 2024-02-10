pipeline{
    agent any
    stages {
        stage('Build Maven') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'khawla-bk', url: 'https://github.com/khawla-bk/DevOps.git']]])

            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                sh 'docker build -t kindest/node:v1.23.4  .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                script {
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u kbenkadida006 -p ${Khawla 666}'
                }  
                    sh 'docker push kindest/node:v1.23.4'
                }
            }
        }
    
        stage('Deploy App on k8s') {
            steps {
                sshagent(['k8s']) {
                    sh "scp -o StrictHostKeyChecking=no nodejsapp.yaml kind-kind@127.0.0.1:/home/k-irwise/vagrant-test"
                script {
                    try{
                        sh "ssh kind-kind@127.0.0.1 kubectl create -f ."
                    }catch(error){
                        sh "ssh kind-kind@127.0.0.1 kubectl create -f ."
                    }
                }
            }
        }
    }
    }
}
