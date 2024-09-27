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
                // Run the Docker container and capture it
                script {
                    def myContainer = docker.image("basic_streamlit_app").run("-p 8501:8501", "--name my_streamlit_container")
                    // Save the container name for cleanup
                    env.CONTAINER_NAME = "my_streamlit_container"
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
