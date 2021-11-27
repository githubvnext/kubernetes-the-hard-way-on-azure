FROM mcr.microsoft.com/azure-cli
WORKDIR /tmp
ENV AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1
RUN wget \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssl \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssljson \
  --no-check-certificate
RUN chmod +x cfssl cfssljson && mv cfssl cfssljson /usr/local/bin/ && cfssl version && cfssljson --version

RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl --no-check-certificate \
    && chmod +x kubectl \
    &&  mv kubectl /usr/local/bin/ && kubectl version --client
VOLUME [ "/root/.ssh" ]
VOLUME [ "/root/.azure" ]
VOLUME [ "/root/scripts" ]

ENTRYPOINT [ "/bin/bash" , "-c"]

# FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine
# RUN apk --update add openjdk7-jre
# RUN gcloud components install app-engine-java kubectl