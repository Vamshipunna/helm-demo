FROM gcr.io/cloud-builders/gcloud

ARG HELM_VERSION=v3.7.0
ENV HELM_VERSION=$HELM_VERSION
ENV GCR_VERSION=2.1.0
COPY helm.bash /builder/helm.bash
							 
RUN chmod +x /builder/helm.bash && \
  mkdir -p /builder/helm && \
  apt-get update && \
  apt-get install -y curl && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /builder/helm linux-amd64 && \
  rm helm.tar.gz && \
  apt-get --purge -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
  
# docker-credential-gcr
RUN curl --fail -sSL -O https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${GCR_VERSION}/docker-credential-gcr_linux_amd64-${GCR_VERSION}.tar.gz -o /builder/docker-credential-gcr ##&& \

RUN ls -ll

RUN tar xvzf docker-credential-gcr.tar.gz 

RUN pwd

RUN ls -la
    
#RUN find / -iname docker-credential-gcr*

RUN ls -ll /builder/

#     rm docker-credential-gcr*.tar.gz && \
#     ls -ll && \
#     ls -ll /builder/helm && \
#     chmod +x docker-credential-gcr*

ENV PATH=/builder/helm/:$PATH
ENV PATH=/builder/docker-credential-gcr/:$PATH

RUN useradd -ms /bin/bash helm

USER helm

# Configure the credential helper for GCR and Artifact Registry
RUN docker-credential-gcr configure-docker -include-artifact-registry

ENTRYPOINT ["/builder/helm.bash"]
