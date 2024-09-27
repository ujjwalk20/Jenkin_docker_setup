pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository from GitHub
                checkout scm // Assumes GitHub repo is configured in Jenkins
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image from the Dockerfile
                script {
                    docker.build("basic_streamlit_app")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Docker container with name and port mapping
                script {
                    // Set the container name in an environment variable
                    env.CONTAINER_NAME = "my_streamlit_container"
                    docker.image("basic_streamlit_app").run("-d -p 8501:8501 --name ${env.CONTAINER_NAME}")
                }
            }
        }
    }

    post {
        always {
            // Clean up any leftover Docker containers/images
            script {
                // Check if the container exists and stop/remove it
                if (env.CONTAINER_NAME) {
                    sh "docker stop ${env.CONTAINER_NAME} || true"
                    sh "docker rm ${env.CONTAINER_NAME} || true"
                }
            }
        }
    }
}
