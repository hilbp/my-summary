FROM golang:1.16

LABEL maintainer  liubp<1435682155@qq.com>
LABEL info "golang devlop envirment"

# copy kubeconfig
COPY kubeconfig /root/.kube/config

RUN  apt-get update

# install kubectl 
RUN \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.21.3/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    true

RUN \
apt-get install -y net-tools && \
apt-get install inetutils-ping && \
true

CMD ["/bin/sh"]

