#!/usr/bin/env bash
set -eo pipefail

CONSUL_DNS_IP=$(kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}' -n kube-system --kubeconfig <(echo $KUBECONFIG | base64 --decode))
cp ${MODPATH}/scripts/stub_domain_template.yaml ${MODPATH}/scripts/stub_domain_apply.yaml
echo -e "    {\"consul\": [\"${CONSUL_DNS_IP}\"]}" >> ${MODPATH}/scripts/stub_domain_apply.yaml

kubectl apply -f ${MODPATH}/scripts/stub_domain_apply.yaml --kubeconfig <(echo $KUBECONFIG | base64 --decode)