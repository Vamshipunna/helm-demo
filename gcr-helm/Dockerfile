# FROM gcr.io/cloud-builders/gcloud

# ARG HELM_VERSION=v3.8.1
# ENV HELM_VERSION=$HELM_VERSION
# ENV GCR_VERSION=2.1.0
# #COPY /builder/helm.bash
							 
# RUN mkdir -p /builder/helm && \
#   apt-get update && \
#   apt-get install -y curl && \
#   curl -SL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
#   tar zxvf helm.tar.gz --strip-components=1 -C /builder/helm linux-amd64 && \
#   rm helm.tar.gz && \
#   apt-get --purge -y autoremove && \
#   apt-get clean && \
#   rm -rf /var/lib/apt/lists/*
  
# #Installing docker-credential-gcr

# # RUN mkdir -p /builder/docker-credential-gcr && \
# #   cd /builder/docker-credential-gcr && \
# #   curl -SL https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${GCR_VERSION}/docker-credential-gcr_linux_amd64-${GCR_VERSION}.tar.gz -o docker-credential-gcr.tar.gz && \
# #   find / -iname docker-credential-gcr.tar.gz && \
# #   tar xvzf docker-credential-gcr.tar.gz && \
# #   rm docker-credential-gcr*.tar.gz && \
# #   chmod +x docker-credential-gcr

# # RUN cp /builder/docker-credential-gcr/docker-credential-gcr /usr/local/bin/

# ENV PATH=/builder/helm/:$PATH
# #ENV PATH=/usr/local/bin/docker-credential-gcr/:$PATH

# # RUN useradd -ms /bin/bash helm

# # USER helm

# # Configure the credential helper for GCR and Artifact Registry
# #RUN /usr/local/bin/docker-credential-gcr configure-docker -include-artifact-registry

# CMD /usr/local/bin/helm

FROM ubuntu:20.04 as build

ENV HELM3_VERSION=3.8.1
ENV GCR_VERSION=2.1.0

RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# docker-credential-gcr
RUN curl --fail -sSL -O https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${GCR_VERSION}/docker-credential-gcr_linux_amd64-${GCR_VERSION}.tar.gz && \
    tar xvzf docker-credential-gcr*.tar.gz && \
    chmod +x docker-credential-gcr

# helm 3
RUN curl -fsSL -o get_helm3.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm3.sh && ./get_helm3.sh --version v${HELM3_VERSION}


FROM ubuntu:20.04 as final

# LABEL maintainer="Team Igneous"
# LABEL maintainer="CLD-TeamIgneous@wellsky.com"

RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/helm /usr/local/bin/
COPY --from=build /docker-credential-gcr /usr/local/bin/

# COPY version-check.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/version-check.sh

RUN useradd -ms /bin/bash helm

USER helm
RUN docker-credential-gcr version
# Configure the credential helper for GCR and Artifact Registry
RUN docker-credential-gcr configure-docker -include-artifact-registry

CMD /usr/local/bin/helm
