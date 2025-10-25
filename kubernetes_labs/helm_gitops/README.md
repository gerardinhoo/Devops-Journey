# Helm + k3s + Traefik (webapp)

This project contains a Helm chart for deploying a simple web
application on a **k3s** cluster using **Traefik** as the ingress
controller.

------------------------------------------------------------------------

## ⚙️ 1. Configure kubeconfig

``` bash
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=$HOME/.kube/config
kubectl get nodes
```

------------------------------------------------------------------------

## 🧩 2. Create Namespace

``` bash
kubectl create namespace webapp --dry-run=client -o yaml | kubectl apply -f -
```

------------------------------------------------------------------------

## 📦 3. Prepare the Helm Chart

Ensure your Helm chart structure looks like this:

    webapp/
    ├── Chart.yaml
    ├── values.yaml
    ├── values/
    │   └── dev.yaml
    └── templates/
        ├── _helpers.tpl
        ├── deployment.yaml
        ├── service.yaml
        ├── ingress.yaml
        └── serviceaccount.yaml

Your `values/dev.yaml`:

``` yaml
fullnameOverride: webapp

replicaCount: 2

image:
  repository: nginx
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: LoadBalancer
  port: 80

ingress:
  enabled: true
  className: traefik
  hosts:
    - host: webapp.local
      paths:
        - path: /
          pathType: Prefix

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 256Mi
```

------------------------------------------------------------------------

## 🚀 4. Deploy the Chart

From inside the `webapp/` folder:

``` bash
helm lint .
helm upgrade --install webapp . -n webapp -f ./values/dev.yaml
```

Verify resources:

``` bash
kubectl -n webapp get deploy,svc,ing,pods
kubectl -n webapp rollout status deploy/webapp
```

------------------------------------------------------------------------

## 🌐 5. Test Ingress

``` bash
NODE_IP=$(kubectl get nodes -o wide --no-headers | awk '{print $6}')
echo "$NODE_IP webapp.local" | sudo tee -a /etc/hosts
curl -H "Host: webapp.local" http://$NODE_IP/
```

------------------------------------------------------------------------

## 🔐 6. Private Image (Optional)

If you use a private GHCR image:

``` bash
kubectl create secret docker-registry ghcr-creds -n webapp   --docker-server=ghcr.io   --docker-username=<github-username>   --docker-password='<PAT with read:packages>'   --docker-email='you@example.com'
```

Then add to your `values/dev.yaml`:

``` yaml
imagePullSecrets:
  - name: ghcr-creds
```

------------------------------------------------------------------------

## 🗂️ 7. Repository Structure

    helm_gitops/
    └── webapp/
        ├── Chart.yaml
        ├── values.yaml
        ├── values/dev.yaml
        └── templates/
            ├── _helpers.tpl
            ├── deployment.yaml
            ├── service.yaml
            ├── ingress.yaml

------------------------------------------------------------------------

## 🧭 8. Notes

-   `fullnameOverride: webapp` ensures stable resource names.
-   Service uses **LoadBalancer** (k3s Klipper LB).
-   Ingress uses **Traefik** (enabled by default in k3s).
-   Perfect starting point before adding **Argo CD** for GitOps sync.
