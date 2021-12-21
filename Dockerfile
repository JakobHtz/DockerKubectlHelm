FROM debian:bookworm-slim

# Set Up
ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN apt upgrade -y
RUN apt install -y curl apt-transport-https ca-certificates gnupg lsb-release

# Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

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
# echo '{"insecure-registries" : ["<repo-url>"]}' > /etc/docker/daemon.json

# Add this to the daemon.json when having problems with mounting aufs
# echo '{"storage-driver": "vfs"}' > /etc/docker/daemon.json

# Set iptables to legacy
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# Configure Kubernetes Cluster
# kubectl config set-cluster <cluster-name> --server=<your-cluster>
# kubectl config set clusters.<cluster-name>.certificate-authority-data <cert-data>
# kubectl config set-credentials <user-name> --token="<user-token>"
# kubectl config set-context <context-name> --cluster=k8s --user=<user-name> --namespace=<your-namespace>
# kubectl config use-context <context-name>

# Start Docker
# service docker start
# docker login <repo-url> -u <name> -p <password>

# Test K8s/Helm/Docker
# kubectl get Pods
# helm list
# docker run hello-world

# Use Image
# docker run --privileged -it <this-image>
