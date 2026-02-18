FROM dokken/ubuntu-20.04

ARG FOLDER=staging

RUN  apt-get update && apt-get install -y wget && apt-get install -y git
RUN apt-get install unzip -y

LABEL maintainer="HashiCorp Terraform"
ARG TERRAFORM_VERSION=1.5.7
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN mv terraform /usr/bin/terraform
RUN apt-get update && apt-get install -y gettext-base

LABEL maintainer="aws installation"
ARG DEBIAN_FRONTEND=noninteractive
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install --update

LABEL maintainer="kubectl"
RUN apt-get install curl -y
RUN curl -LO "https://dl.k8s.io/release/v1.29.3/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN chmod +x kubectl
RUN mkdir -p ~/.local/bin/kubectl
RUN mv ./kubectl ~/.local/bin/kubectl
RUN apt update
RUN apt install nano


# Configure bash history globally
LABEL maintainer="Bash History Configuration"
RUN echo 'export HISTSIZE=10000' >> /etc/bash.bashrc && \
    echo 'export HISTFILESIZE=20000' >> /etc/bash.bashrc && \
    echo 'export HISTCONTROL=ignoredups:erasedups' >> /etc/bash.bashrc && \
    echo 'export PROMPT_COMMAND="history -a; history -c; history -r"' >> /etc/bash.bashrc

# Ensure history file exists
RUN touch /root/.bash_history

# # Helm installation
# RUN curl -LO https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz
# RUN tar -C /tmp/ -zxvf helm-v3.7.0-linux-amd64.tar.gz
# RUN rm helm-v3.7.0-linux-amd64.tar.gz
# RUN mv /tmp/linux-amd64/helm ~/.local/bin/helm
# # RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
# # RUN apt-get install apt-transport-https --yes
# # RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# # RUN apt-get update
# # RUN apt-get install helm

# and then add ~/.local/bin/kubectl to $PATH
COPY . /${FOLDER}
WORKDIR /${FOLDER}
ENTRYPOINT ["/bin/bash", "build/entrypoint.sh"]
# ENTRYPOINT ["/bin/bash", "-c", "pwd && ls -la && sleep 1000"]