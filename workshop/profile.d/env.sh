#echo "Hello from your Terminal"

export REGISTRY_HOST=tanzupartnerworkshop.azurecr.io

export REGISTRY_USERNAME=$(kubectl get secret registry-credentials -n tap-install -o json | jq -r '.data.".dockerconfigjson"' | base64 -d | jq -r '.auths."tanzudemoreg.azurecr.io".username')

#echo $REGISTRY_USERNAME

export REGISTRY_PASSWORD=$(kubectl get secret registry-credentials -n tap-install -o json | jq -r '.data.".dockerconfigjson"' | base64 -d | jq -r '.auths."tanzudemoreg.azurecr.io".password')

# Login to Docker Registry

docker login $REGISTRY_HOST -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD

# Rename eduk8s context to tap cluster name

kubectl config rename-context eduk8s tap12-aks-fullcluster

# Switch to default namespace
# kubectl config set-context --current --namespace default

# Get GITea Creds to push changes

export GIT_USERNAME=$(kubectl get secret gitea-secret -n tap-install -o json | jq -r '.data.username' | base64 -d)
export GIT_PASSWORD=$(kubectl get secret gitea-secret -n tap-install -o json | jq -r '.data.password' | base64 -d)
export GIT_HOST=gitea-tapdemo.captainvirtualization.in

# Setup GIT for change commit
git config --global user.email "$GIT_USERNAME@gitea.com"
git config --global user.name $GIT_USERNAME


# Other Variables

#export ACC_SERVER_URL="https://accelerator.tap11.tanzupartnerdemo.com"

export ARGOCD_USERNAME=admin
export ARGOCD_PASSWORD=pwd

clear


#exec bash
