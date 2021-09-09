FROM ubuntu:20.04

# Set Up
ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install -y curl apt-transport-https ca-certificates gnupg lsb-release systemctl build-essential git

# Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Kubernetes
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

# Helm
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

# Install
RUN apt update
RUN apt install -y docker-ce docker-ce-cli containerd.io kubectl helm

# Configure Docker Registry
# mkdir /etc/docker/
# echo '{"insecure-registries" : ["your.repo"]}' > /etc/docker/daemon.json

# Configure Kubernetes Cluster
# kubectl config set-cluster k8s --server="your-cluster"
# kubectl config set clusters.k8s.certificate-authority-data ""
# kubectl config set-credentials gitlab --token=""
# kubectl config set-context gitlab-runner --cluster=k8s --user=gitlab --namespace=ym-autocomplete
# kubectl config use-context gitlab-runner

# Start Docker
# service docker start
# docker login your-repo -u name -p pass 

# Test K8s/Helm/Docker
# kubectl get Pods
# helm list
# docker run hello-world

# Use Image
# docker run --privileged -it this-image