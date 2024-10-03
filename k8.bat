@echo off
:: Start Minikube
minikube start

:: Apply the Streamlit deployment configuration
kubectl apply -f streamlit-deployment.yaml

:: Apply the Streamlit service configuration
kubectl apply -f streamlit-service.yaml

:: Get the URL for the Streamlit service
minikube service streamlit-service --url

:: Pause the terminal to keep it open
pause
