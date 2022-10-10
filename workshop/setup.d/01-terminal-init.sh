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

export METADATA_STORE_ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6Im5sRTZvY0pTMVFnTmxDekZYMnAxc0JBeXZwX3RCMnNOaG5vZno3b0ZUem8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtZXRhZGF0YS1zdG9yZSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudC10b2tlbi04Z3dzOCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjllNmE4YzVhLTc4YmItNGZmZi1iZmNkLWI0MWIxNWI0ZThmYSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptZXRhZGF0YS1zdG9yZTptZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCJ9.G2OUNHFzmdrZeq_ICU019HYttn8G19D5ajIPVfuPESijToycD4yGqBDWmK6mpUO465MwgzlMvhz5cujw-V-sGoPpGaHSx-HJu3lxbC4jra0KveHS_BjSnAGlIVzRWSRTF5qq2EjhSHLC6hMV85HDGCEsJgB45hssa_LsolFGsx1EbRZNcIVFjlnTVmaJeYV_Ox9LYT_QVwsscDl-i5VuJTRsD3ZEUNgRP0ffajQ6LTYooVCUoSX01s25J55UZYB0b6Uvbz6eK3xqKSqGk_UzNren4NtNZCFwHO6_w0Dwo5gXUamhIpBt3F4mmZVdQiM3h5aGjzWakKRZ3yH5CVNyt1mrlU568mRR22bOENfxvnlWy_ea66yA529nTEGIldOYIRaofefEN__BLfSUKl4DdrlY7Cpy39ca1qKp4fpZzAkBSLhqrMkrn1OC3neOV_91yesleP0dEAO6sibi3-D7t-_dHfiPLwDtbtHQa6ufGcF6kFt3zFBYv50ZNkmukeFkCiwtriDwXETN9OR6cszWVKf8CEZYfE4-0QiwlEM70GHZHYmBYBEOKr-E11qwdACU0As2akfNKFo-lG4J_4a11LOiKMvQotxnKsE16GvJLANpF-_cMXM26sVUGUVeyDjN8W_6dWYZevCTITJ0Bi5GNn8NpQchpr-TQytkjEHMvBo"
