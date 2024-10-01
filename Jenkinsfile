pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')  // Docker Hub credentials stored in Jenkins
        DOCKER_IMAGE = "ujjwalk20/my_streamlit_app"
        DOCKER_TAG = "latest"
        REPO_URL = "https://github.com/ujjwalk20/Jenkin_docker_setup.git"
    }
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

         stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using Docker plugin
                    def dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

     stage('Push Docker Image to Docker Hub') {
               
                steps {
                    script {
                        // Use credentials for Docker Hub login
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                            // Push the Docker image to Docker Hub
                            docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        }
                    }
                }
            }
        stage('Deploy to Kubernetes via Minikube') {
        
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'streamlit-deployment.yaml',  // Deployment YAML file for Kubernetes
                        kubeconfigId: 'minikube-kubeconfig',    // Jenkins kubeconfig ID for accessing Minikube
                        enableConfigSubstitution: true
                    )
                    
                    kubernetesDeploy(
                        configs: 'streamlit-service.yaml',  // Service YAML file for Kubernetes
                        kubeconfigId: 'minikube-kubeconfig',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
    } 
}
