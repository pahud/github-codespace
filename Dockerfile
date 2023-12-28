FROM public.ecr.aws/jsii/superchain:1-buster-slim-node18

ARG KUBECTL_URL='https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/linux/amd64/kubectl'
ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
ARG TERRAFORM_URL='https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_darwin_amd64.zip'

USER root:root

# install jq wget
RUN apt-get update && apt-get install -y jq wget

RUN mv $(which aws) /usr/local/bin/awscliv1 && \
  curl "${AWS_CLI_V2_URL}" -o "/tmp/awscliv2.zip" && \
  unzip /tmp/awscliv2.zip -d /tmp && \
  /tmp/aws/install

# install kubectl
RUN curl -o kubectl "${KUBECTL_URL}" && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin

# install terraform
RUN curl -o terraform.zip "${TERRAFORM_URL}" && \
  unzip terraform.zip && \
  mv terraform /usr/local/bin/ && \
  rm -f terraform.zip

USER superchain:superchain