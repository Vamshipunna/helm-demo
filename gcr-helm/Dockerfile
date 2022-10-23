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

ENV PATH=/builder/helm/:$PATH

# RUN useradd -ms /bin/bash helm
# USER helm

CMD /usr/local/bin/helm
