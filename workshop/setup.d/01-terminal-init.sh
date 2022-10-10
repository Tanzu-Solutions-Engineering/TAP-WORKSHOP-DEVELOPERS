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

export METADATA_STORE_ACCESS_TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6Ik9iM0V2NDBHZUczX003cmFWMFF2dE01OWRfSUJmcFVKWjRZYkNNc3RGUXMifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtZXRhZGF0YS1zdG9yZSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudC10b2tlbi1kcnE1aCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJtZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjdiNGM2ZDI2LWE0ZTQtNDJmMS1iMjNkLWI0ODViMTJkMTA3ZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptZXRhZGF0YS1zdG9yZTptZXRhZGF0YS1zdG9yZS1yZWFkLXdyaXRlLWNsaWVudCJ9.RZodH4bmH6NveJdyo4ZXB4lrJ0urrtXA9zziu15rugnlQHloXQNgoqPbcRerQSKCSFgWdQtA-dbcIpSVShqih-S68YlJvsgqDqfDk7WJVVwwspX-L6bUS2K1F_yAGq4OR5sZzEc79eJNhf6YBia9o4N_amdLYhkyQPjPRHfELBISgDRNhx-fSVsuuOcu3eOUZOHNnjR2EdHnVZL3zgefrFFQVVahb5fxX2ibuhr3Te9W3hbBYBe9vixrC3Bti_DHAwb30WUxpSH6TunebCOeIi1jgUk4tc8f5YhXjL3UqOoghZ9jysvgvmOMBpQKpriryuZ7u2xMJhgeh7wUONoWSDFdxSk1Rq9hi6CUQypP7qPNwXAEyWXgnwNoWnzqMoD73lMxc1uolEFVqVPOczytHOk6GI6D4gp0HgJwdFhZRlbsiFW4J7wdDpVwots8o-AFttRTdkzCPo3R89AkcMdOh5Po62xbk4ZeGmeJkXpWEXTlVsIXHjHC7r9Az0-yz8PH1_T5WjZ4ACSQqHxdGzv-h2OQ_4EyEKPsUyScWnuXxPqfnzkOXe661ZmOfoO72FGDCQTGITvzfKkTUkZ6Olp1hAL5h9jb0wL92XYhBmAEYs9jCmlE9IWxflVE2cSY6LJMuJPRXEICIJ5XKYpaf0A8nB3qLu7PiMSU4wC9nfzR0ao"
