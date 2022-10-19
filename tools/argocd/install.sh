# Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/
# Ref: https://blog.knoldus.com/how-to-set-up-argo-cd-in-ubuntu/

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#kubectl -n argocd get all
#kubectl -n argocd get po
#kubectl -n argocd get svc

# argo CLI installation
# Ref: https://argo-cd.readthedocs.io/en/stable/cli_installation/
wget https://github.com/argoproj/argo-cd/releases/download/v2.2.5/argocd-linux-amd64 -O argocd
sudo mv ./argocd /usr/local/bin/argocd
sudo chmod +x /usr/local/bin/argocd
#which argocd

# Change the argocd-server service type to LoadBalancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# GUI: https://localhost:8080
# Kubectl port-forwarding can also be used to connect to the API server without exposing the service.
kubectl port-forward svc/argocd-server -n argocd 8080:443
#Forwarding from 127.0.0.1:8080 -> 8080
#Forwarding from [::1]:8080 -> 8080

# username: admin
# password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# CLI login
argocd login localhost:8080

# update password
argocd account update-password
