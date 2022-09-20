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
export GIT_HOST=gitea-tapdemo.captainvirtualization.in

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
