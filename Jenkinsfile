pipeline {
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
                    dockerImage = docker.build("test_streamlit_app")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Use Docker plugin to find if the container "frosty_wozniak" exists
                    def existingContainer = docker.ps('--all').find { it.names.contains("frosty_wozniak") }

                    // If the container exists, stop and remove it
                    if (existingContainer) {
                        docker.image("basic_streamlit_app").withRun('-p 8501:8501 --name my_app_container') {
                            docker.image("basic_streamlit_app").stop(existingContainer.id)
                            docker.image("basic_streamlit_app").rm(existingContainer.id)
                        }
                    }
                    
                    // Run the new container using Docker plugin
                    docker.image("basic_streamlit_app").run('-d -p 8501:8501 --name my_app_container')
                }
            }
        }
    }
}
