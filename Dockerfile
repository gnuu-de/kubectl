FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew wireguard-dkms wireguard-tools
RUN snap install kubectl --classic

LABEL version="1.0.0"
LABEL name="kubectl"
LABEL repository="http://github.com/steebchen/kubectl"
LABEL homepage="http://github.com/steebchen/kubectl"

LABEL maintainer="Luca Steeb <contact@luca-steeb.com>"
LABEL com.github.actions.name="Kubernetes CLI - kubectl"
LABEL com.github.actions.description="Runs kubectl. The config can be provided with the secret KUBE_CONFIG_DATA."
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
