FROM ubuntu:20.04 as build

ENV HELM3_VERSION=3.8

RUN set -x && apt-get update && apt-get install curl -y 
    
RUN curl -fsSL -o get_helm3.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm3.sh && ./get_helm3.sh --version v${HELM3_VERSION}
    
WORKDIR /app
COPY ./requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
