#!/bin/bash
set -e

kubectl create namespace prometheus || echo "Namespace already exists"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace prometheus
# get credentials to the Grafana
echo "Grafana password:" && \
    kubectl get secret --namespace prometheus prometheus-grafana -o=jsonpath='{.data.admin-password}' | base64 -d
echo -e "\nGrafana username:" && \
    kubectl get secret --namespace prometheus prometheus-grafana -o=jsonpath='{.data.admin-user}' | base64 -d