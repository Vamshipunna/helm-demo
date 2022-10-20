FROM ubuntu:20.04 as build

ENV HELM3_VERSION=3.8.1
ENV GCR_VERSION=2.1.0

RUN export HELM_CACHE_HOME=/tmp
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

RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/helm /usr/local/bin/
COPY --from=build /docker-credential-gcr /usr/local/bin/

# COPY version-check.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/version-check.sh

RUN useradd -ms /bin/bash helm

USER helm

# Configure the credential helper for GCR and Artifact Registry
RUN docker-credential-gcr configure-docker -include-artifact-registry

CMD /usr/local/bin/helm
