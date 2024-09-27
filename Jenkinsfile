pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository that contains the Dockerized Streamlit app
                git url: 'https://github.com/your-username/your-repository.git', branch: 'main'
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
                // Run the Docker container
                script {
                    docker.image("basic_streamlit_app").run("-p 8501:8501")
                }
            }
        }
    }

    post {
        always {
            // Clean up any leftover Docker containers/images
            script {
                def container = docker.image("basic_streamlit_app")
                container.stop()
                container.remove()
            }
        }
    }
}
