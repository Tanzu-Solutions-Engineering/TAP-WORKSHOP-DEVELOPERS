#printf %b "$KUBE_CONFIG" > config
#envsubst < config > .kube/config

#envsubst < /home/eduk8s/install/rbac/app-editor.yaml | kubectl apply -f-

export USERNAME1=`kubectl get secret registry-credentials -n tap-install -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export REGISTRY_USERNAME=$(echo $USERNAME1 | base64 -d | jq '.auths[].username' | tr -d '"')

echo $REGISTRY_USERNAME

export PASSWORD1=`kubectl get secret registry-credentials -n tap-install -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export REGISTRY_PASSWORD=$(echo $PASSWORD1 | base64 -d | jq '.auths[].password' | tr -d '"')

export REGISTRY_HOST=tanzupartnerworkshop.azurecr.io

echo $REGISTRY_HOST

# Login to Docker Registry

docker login $REGISTRY_HOST -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD

export REPO_NAME=$SESSION_NAMESPACE-$(date +%s)

export GIT_USERNAME=$(kubectl get secret gitea-secret -n tap-install -o json | jq -r '.data.username' | base64 -d)
export GIT_PASSWORD=$(kubectl get secret gitea-secret -n tap-install -o json | jq -r '.data.password' | base64 -d)
export GIT_HOST=gitea-tapdemo.tap.tanzupartnerdemo.com

mkdir partnertapdemo
cd partnertapdemo
echo "# TAP Demo for Tanzu Partners" >> README.md
git init
git checkout -b main
git config user.name $GIT_USERNAME
git config user.email "$GIT_USERNAME@gitea.com"
git add .
git commit -a -m "Initial Commit"

git remote add origin https://$GIT_USERNAME:$GIT_PASSWORD@${GIT_HOST}/$GIT_USERNAME/$REPO_NAME.git
git push -u origin main

cd ..

export METADATA_STORE_ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6IkQtRzdNZ0M5Z2JoNUEtZzkxZFFaZWJLbGtBMlRIdTFIQndyQUx4Q0Z0RzAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtZXRhZGF0YS1zdG9yZSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjRmOTIzNmUxLTY2MjUtNDkzZS1hNzA5LWQwY2Y1ZjJjY2UwYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptZXRhZGF0YS1zdG9yZTptZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCJ9.eB5cYltaiOEDE8T2EmO0Bxv_0fk_A8cv01AuxZbLx1KEydKy0sMx9M4VWA3XlL8LAAix_90FLBhiXZZ8DmS4SBNrm9jfcDzrsi_HJiXdfAAgDyO9O8GiV2m-W9jbK6D0X99OIL7UcRLVhE9RSOqZCsaePXCmN7hr9QHUqK5O0V0hqwPcceaudF7rD0jU1wTp5vXwb3GO2mto5yr90Yxngv2sOTbjJD6tqq4lgv-HCetqDq2zLMeV-kRn9kS-RKAEx8MkuBBWldUDo2vALl2ZGUjtP9ZVCKeCRd6Qs7yoOWVGz7caTF8g1DH9BcUvPEA0uerFSulY7XOwcJUgszQqwYGVxTDMWtAR2POSAs2f6QmMDITDcIitUwV7zS5Jy0ikedGnJW0SNAkz56aoXDKNS1ZvvI6YnRZ6tiZnvyhXqUyHtTXiXxd5-g9JHL7e1dPv7_8TeNeQXVKREpKtNv0e0-Jna9n5El72kHDSogwE5dernHIsoUYaqwIpflylE3SPJWhyQSJM1wFq-xjrxllr75ArQW4K-eywz78vR11UYoWOOEReySe7oAjYkC2GF-orWLWPULS_iZ4r-ryP9Z6XxH1D28UgXFfAT0QCtjFX4-xpBdnMHHTOh4JXrP3xDAT2uj_npCqxYbXg2zvWJhCbxiQxv2a42-iDWa7ZdUDT0Gk"
