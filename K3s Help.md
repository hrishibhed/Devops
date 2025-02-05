-----KUBERNETS USERFULL COMMANDS----

K3s Installation

# curl -sfL https://get.k3s.io | sh -

# sudo systemctl status k3s

view config file:
# sudo nano /etc/rancher/k3s/k3s.yaml

Get token:
# sudo cat /var/lib/rancher/k3s/server/node-token

Add an node:

# curl -sfL https://get.k3s.io | K3S_URL=https://128.199.131.16:6443 K3S_TOKEN=K10d80cf2d5de51b0a32d8c7ad502c38dcd3bc451ba6d2b5b3e6f94034efb9f4a35::server:65a20b61663719b4f065428666f93eb3 sh -

# kubectl get nodes/pods/svc/namespaces/deployments

# kubectl get svc --all-namespaces -o wide

# kubectl apply -f filename.yaml


--- INSTALLING NGINX INGRESS --

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/do/deploy.yaml


---- INSTALL KCERT for getting ssl/tsl certificates ---

# helm repo add nabsul https://nabsul.github.io/helm

# kubectl create ns kcert


---FOR TESTING---

# helm install kcert nabsul/kcert -n kcert --debug --set acmeTermsAccepted=true,acmeEmail=hrishibhed183@gmail.com


---FOR PRODUCTION----

# helm install kcert nabsul/kcert -n kcert --debug --set acmeTermsAccepted=true,acmeEmail=hrishibhed183@gmail.com,acmeDirUrl=https://acme-v02.api.letsencrypt.org/directory

# helm uninstall kcert nabsul/kcert -n kcert (to remove the already added testing kcert pods)


