FROM golang:1.16

COPY config ~/.kube/

RUN  \
    apt-get update

RUN \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.21.3/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    sudo mv ./kubectl /usr/local/bin/kubectl && \
    true

CMD ["/bin/sh"]

