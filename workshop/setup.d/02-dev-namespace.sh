#!/bin/bash
set -x
set +e

export REGISTRY_HOST=tanzudemoreg.azurecr.io

export REGISTRY_USERNAME=$(kubectl get secret registry-credentials -n default -o json | jq -r '.data.".dockerconfigjson"' | base64 -d | jq -r '.auths."tanzudemoreg.azurecr.io".username')

#echo $REGISTRY_USERNAME

export REG_PASSWORD=$(kubectl get secret registry-credentials -n default -o json | jq -r '.data.".dockerconfigjson"' | base64 -d | jq -r '.auths."tanzudemoreg.azurecr.io".password')


REGISTRY_PASSWORD=$REG_PASSWORD kp secret create registry-credentials --registry ${REGISTRY_HOST} --registry-user $REGISTRY_USERNAME

