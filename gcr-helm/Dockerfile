FROM gcr.io/cloud-builders/gcloud

ARG HELM_VERSION=v3.8.1
ENV HELM_VERSION=$HELM_VERSION
ENV GCR_VERSION=2.1.0
#COPY /builder/helm.bash
							 
RUN mkdir -p /builder/helm && \
  apt-get update && \
  apt-get install -y curl && \
  curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
  tar zxvf helm.tar.gz --strip-components=1 -C /builder/helm linux-amd64 && \
  rm helm.tar.gz && \
  apt-get --purge -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
  
#Installing docker-credential-gcr

# RUN mkdir -p /builder/docker-credential-gcr && \
#   cd /builder/docker-credential-gcr && \
#   curl -SL https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${GCR_VERSION}/docker-credential-gcr_linux_amd64-${GCR_VERSION}.tar.gz -o docker-credential-gcr.tar.gz && \
#   find / -iname docker-credential-gcr.tar.gz && \
#   tar xvzf docker-credential-gcr.tar.gz && \
#   rm docker-credential-gcr*.tar.gz && \
#   chmod +x docker-credential-gcr

# RUN cp /builder/docker-credential-gcr/docker-credential-gcr /usr/local/bin/

ENV PATH=/builder/helm/:$PATH
#ENV PATH=/usr/local/bin/docker-credential-gcr/:$PATH

# RUN useradd -ms /bin/bash helm

# USER helm

# Configure the credential helper for GCR and Artifact Registry
#RUN /usr/local/bin/docker-credential-gcr configure-docker -include-artifact-registry

CMD /usr/local/bin/helm
