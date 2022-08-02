export REGISTRY_HOST=tanzudemoreg.azurecr.io
echo $REGISTRY_HOST
export USERNAME1=`kubectl get secret registry-credentials -n default -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export REGISTRY_USERNAME=$(echo $USERNAME1 | base64 -d | jq '.auths[].username' | tr -d '"')
echo $REGISTRY_USERNAME
export PASSWORD1=`kubectl get secret registry-credentials -n default -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export REGISTRY_PASSWORD=$(echo $PASSWORD1 | base64 -d | jq '.auths[].password' | tr -d '"')
# Login to Docker Registry
docker login $REGISTRY_HOST -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD

# Rename eduk8s context to tap cluster name

kubectl config rename-context eduk8s tap11-aks-fullcluster

# Switch to default namespace
kubectl config set-context --current --namespace default

# Get GIT Creds to push changes
export GIT_USERNAME1=`kubectl get secret git-secret -n default -o json | jq '.data.username' | tr -d '"'`
export GIT_PASSWORD1=`kubectl get secret git-secret -n default -o json | jq '.data.password' | tr -d '"'`
export GIT_USERNAME=$(echo $GIT_USERNAME1 | base64 -d | tr -d '"')
#echo $GIT_USERNAME
export GIT_PASSWORD=$(echo $GIT_PASSWORD1 | base64 -d | tr -d '"')

# Setup GIT for change commit
git config --global user.email "dinesh.tripathi30@gmail.com"
git config --global user.name $GIT_USERNAME


# Other Variables

#export ACC_SERVER_URL="https://accelerator.tap11.tanzupartnerdemo.com"
