#!/bin/bash

echo "updating apt repo's."
sudo apt update &> /dev/null
sudo snap install aws-cli --classic &> /dev/null
echo "aws-cli installed"
sudo snap install trivy &> /dev/null
echo "trivy installed"
sudo snap install kubectl --classic &> /dev/null
echo "kubectl installed"
sudo snap install helm --classic &> /dev/null
echo "helm installed"
sudo snap install docker &> /dev/null
echo "docker installed"
echo 
echo "Configuring Docker..."
USER=$(whoami)
sudo addgroup --system docker 
sudo adduser $USER docker 
sudo snap disable docker && sudo snap enable docker
echo "All Set!!"