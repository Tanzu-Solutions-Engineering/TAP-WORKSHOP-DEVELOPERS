export REGISTRY_HOST=tanzudemoreg.azurecr.io

export USERNAME1=`kubectl get secret registry-credentials -n default -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export USERNAME=$(echo $USERNAME1 | base64 -d | jq '.auths[].username' | tr -d '"')

export PASSWORD1=`kubectl get secret registry-credentials -n default -o json | jq '.data' | cut -f2 -d":"|tr -d \" | awk 'NR>1 && NR < 3'`

export PASSWORD=$(echo $PASSWORD1 | base64 -d | jq '.auths[].password' | tr -d '"')

# Rename eduk8s context to tap cluster name

kubectl config rename-context eduk8s tap11-aks-fullcluster

# Switch to default namespace
kubectl config set-context --current --namespace default

