#!/bin/sh

set -e

mkdir -p /etc/wireguard

echo "$WIREGUARD_CONF" | base64 --decode > /etc/wireguard/wg0.conf
wg-quick up wg0
ping -c 5 10.4.0.1

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

sh -c "kubectl${KUBECTL_VERSION:+.${KUBECTL_VERSION}} $*"
