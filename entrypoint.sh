#!/bin/sh

set -e

cat /etc/os-release

wg genkey | tee privatekey | wg pubkey > publickey
wg genpsk > preshared

wg show

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

sh -c "kubectl${KUBECTL_VERSION:+.${KUBECTL_VERSION}} $*"
