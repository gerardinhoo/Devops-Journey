# Kubernetes Labs – Phase 1 → Phase 2 (Part 1)

Hands-on labs for learning Kubernetes from fundamentals to production patterns using **Minikube** on macOS (Apple Silicon).

## 🧱 Prereqs

- Docker Desktop (or Colima)
- Minikube
- kubectl

```bash
minikube start --driver=docker
kubectl get nodes
```

---

## 1) First App (Imperative)

```bash
kubectl create deployment nginx-deploy --image=nginx:1.25-alpine
kubectl expose deployment nginx-deploy --type=NodePort --port=80
minikube service nginx-deploy
```

Inspect:

```bash
kubectl get deploy,rs,pods,svc -o wide
kubectl describe deploy nginx-deploy
```

---

## 2) Declarative: Deployment + Service

**Files**

- `nginx-deploy.yaml` – Deployment with probes & resources.
- `nginx-svc.yaml` – NodePort Service.

```bash
kubectl apply -f nginx-deploy.yaml
kubectl apply -f nginx-svc.yaml
minikube service nginx-svc
```

Scale / Update / Rollback:

```bash
kubectl scale deploy/nginx-deploy --replicas=4
kubectl set image deploy/nginx-deploy nginx=nginx:1.27-alpine --record
kubectl rollout status deploy/nginx-deploy
kubectl rollout history deploy/nginx-deploy
kubectl rollout undo deploy/nginx-deploy
```

Troubleshoot:

```bash
kubectl logs -f <pod>
kubectl describe pod <pod>
kubectl exec -it <pod> -- sh
```

---

## 3) ReplicaSet vs Deployment

- `replicaset.yaml` – shows raw RS usage (no rollouts).

```bash
kubectl apply -f replicaset.yaml
kubectl get rs,pods
kubectl scale rs nginx-rs --replicas=5
kubectl delete -f replicaset.yaml
```

---

## 4) ConfigMap (App Config)

**Files**

- `configmap.yaml` – defines `APP_MODE`, `APP_VERSION`, `WELCOME_MSG`.
- `nginx-with-config.yaml` – Deployment consuming ConfigMap via `envFrom`.

```bash
kubectl apply -f configmap.yaml
kubectl apply -f nginx-with-config.yaml
kubectl exec -it $(kubectl get pod -l app=nginx-with-config -o name) --   sh -c 'env | grep -E "APP_|WELCOME_MSG"'
```

> Note: env vars from ConfigMaps are captured at pod start. Update the map → `kubectl rollout restart deploy/nginx-with-config`.

---

## 5) Secret (Sensitive Config)

**Files**

- `secret.yaml` – base64 values for `DB_USER`, `DB_PASSWORD`.
- `nginx-with-secret.yaml` – Deployment consuming Secret via `envFrom`.

```bash
kubectl apply -f secret.yaml
kubectl apply -f nginx-with-secret.yaml
kubectl exec -it $(kubectl get pod -l app=nginx-with-secret -o name) --   sh -c 'env | grep DB_'
```

---

## Namespaces (optional)

```bash
kubectl create ns demo
kubectl apply -n demo -f nginx-deploy.yaml -f nginx-svc.yaml
kubectl get all -n demo
```

---

## Cleanup

```bash
kubectl delete -f nginx-with-secret.yaml -f secret.yaml
kubectl delete -f nginx-with-config.yaml -f configmap.yaml
kubectl delete -f nginx-svc.yaml -f nginx-deploy.yaml
kubectl delete -f replicaset.yaml || true
minikube stop
```

---

## What I learned (highlights)

- Kubernetes control plane and reconciliation loop.
- Declarative manifests, rollouts, rollbacks, scaling.
- ConfigMap/Secret patterns (env injection).
- Core troubleshooting with `describe`, `logs`, `exec`.

# 🧱 Kubernetes Phase 2 – Part 2: Persistent Volumes (PV) & Persistent Volume Claims (PVC)

## 📘 Overview

In this phase, we focused on **persistent storage** in Kubernetes — understanding how **Persistent Volumes (PVs)**, **Persistent Volume Claims (PVCs)**, and **Pods** work together to maintain data beyond container or pod lifecycles.

This forms the foundation for **stateful applications** and **data durability** within Kubernetes clusters.

---

## 🧩 Concepts Covered

### 1. Persistent Volume (PV)

A **cluster-wide storage resource** managed by the administrator or dynamically provisioned by StorageClasses.

- PVs are independent of Pods.
- They define the actual storage implementation (e.g., `hostPath`, NFS, AWS EBS, GCE Persistent Disk).

**YAML Example:**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: '/mnt/data'
```

---

### 2. Persistent Volume Claim (PVC)

A **request** for storage by a Pod. PVCs consume PVs based on matching attributes like storage class, access mode, and size.

**YAML Example:**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 512Mi
  storageClassName: manual
```

---

### 3. Pod Using PVC (Persistent Volume Mount)

**YAML Example:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pv-demo
spec:
  containers:
    - name: nginx
      image: nginx:1.25-alpine
      volumeMounts:
        - name: data-volume
          mountPath: /usr/share/nginx/html
  volumes:
    - name: data-volume
      persistentVolumeClaim:
        claimName: my-pvc
```

---

## ⚙️ Commands Used

```bash
# Apply PV and PVC
kubectl apply -f persistent-volume.yaml
kubectl apply -f persistent-volume-claim.yaml

# Check status
kubectl get pv,pvc

# Deploy pod that uses PVC
kubectl apply -f nginx-pv-demo.yaml

# Verify pod and persistence
kubectl exec -it nginx-pv-demo -- sh
echo "Hello Persistent Kubernetes!" > /usr/share/nginx/html/index.html
cat /usr/share/nginx/html/index.html

# Delete and recreate pod
kubectl delete pod nginx-pv-demo
kubectl apply -f nginx-pv-demo.yaml

# Data should still persist
kubectl exec -it nginx-pv-demo -- cat /usr/share/nginx/html/index.html
```

---

## ✅ Key Learnings

- **Persistent Volumes (PVs)** are managed by the cluster admin.
- **Persistent Volume Claims (PVCs)** are requests from users or pods.
- **Pods** can mount PVCs to persist data beyond their lifecycle.
- The **`Retain` reclaim policy** preserves data even after the PVC is deleted.
- Verified data persistence after pod deletion and recreation.

---

## 📁 Files in This Phase

| File                           | Description                                       |
| ------------------------------ | ------------------------------------------------- |
| `persistent-volume.yaml`       | Defines the PersistentVolume resource             |
| `persistent-volume-claim.yaml` | Defines the PersistentVolumeClaim resource        |
| `nginx-pv-demo.yaml`           | Pod manifest mounting the PVC to test persistence |
| `README.md`                    | This documentation file                           |

---

# 🌐 Kubernetes Phase 3 – Networking, Security & Ingress

## 📘 Overview

In this phase, we explored how Kubernetes manages **networking, ingress, and security** to control how services communicate inside and outside the cluster.  
This stage mirrors **real-world production networking** and prepares you for secure, scalable multi-service architectures.

---

## 🧩 Concepts Covered

### 1. Kubernetes Networking Fundamentals

- Every **Pod** gets its own IP address.
- Pods can communicate directly within the same cluster.
- **Services** provide stable endpoints even when Pods change.
- Kubernetes networking is **flat** — no NAT between Pods in the same cluster.

---

### 2. Service Types

| Service Type     | Description                                           | Use Case                                 |
| ---------------- | ----------------------------------------------------- | ---------------------------------------- |
| **ClusterIP**    | Default; internal-only communication                  | Pod-to-Pod or microservice communication |
| **NodePort**     | Exposes app externally on a Node’s IP and static port | Local testing or minimal exposure        |
| **LoadBalancer** | Cloud-managed external access                         | Real-world external access in GKE/EKS    |
| **ExternalName** | Maps a service to an external DNS name                | Integration with external systems        |

**Hands-on files:**

- `nginx-clusterip.yaml`
- `nginx-nodeport.yaml`
- `nginx-loadbalancer.yaml`

---

### 3. Ingress Controllers & Ingress Resources

**Goal:** Expose multiple services under a single external IP with host/path-based routing.

We installed the **NGINX Ingress Controller** using:

```bash
minikube addons enable ingress
```

Created an **Ingress resource**:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: myapp.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-svc
                port:
                  number: 80
```

We mapped the hostname locally in `/etc/hosts`:

```
127.0.0.1 myapp.local
```

✅ Accessed app securely at:

```
http://myapp.local
```

---

### 4. Network Policies (Pod-Level Firewall)

Created a **deny-all** network policy to restrict communication between pods:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Ingress
```

Effect: Blocks all incoming connections unless explicitly allowed.

---

## ⚙️ Commands Summary

```bash
# Create and view services
kubectl apply -f nginx-clusterip.yaml
kubectl apply -f nginx-nodeport.yaml
kubectl apply -f nginx-loadbalancer.yaml
kubectl get svc

# Enable ingress controller
minikube addons enable ingress

# Apply ingress resource
kubectl apply -f ingress-demo.yaml

# Test DNS & access
curl http://myapp.local

# Create and apply network policy
kubectl apply -f networkpolicy-deny-all.yaml

# Create TLS secret
kubectl create secret tls myapp-tls --key tls.key --cert tls.crt
kubectl get secrets
```

---

## ✅ Key Learnings

- **Services** decouple Pods from client access.
- **Ingress** routes multiple services under one domain.
- **NetworkPolicies** add security boundaries between pods.
- Learned how **Minikube** mimics **LoadBalancer** environments locally.

---

## 📁 Files in This Phase

| File                          | Description                               |
| ----------------------------- | ----------------------------------------- |
| `nginx-clusterip.yaml`        | Internal-only service example             |
| `nginx-nodeport.yaml`         | External service using NodePort           |
| `nginx-loadbalancer.yaml`     | LoadBalancer service example              |
| `ingress-demo.yaml`           | Ingress configuration for routing traffic |
| `networkpolicy-deny-all.yaml` | Restrictive network policy                |
| `README.md`                   | This documentation file                   |

---

## 🧠 What’s Next (Phase 4 – Scaling, Monitoring & CI/CD)

Next, make apps **production-ready** by learning:

- **Horizontal Pod Autoscaling (HPA)**
- **Metrics Server Installation**
- **Prometheus & Grafana Monitoring**
- **Centralized Logging (ELK/EFK)**
- **GitHub Actions / Jenkins for K8s CI/CD**
- **Canary Deployments & Rolling Updates**

---

**Author:** [Gerard Eklu](https://github.com/gerardinhoo)  
**Repository:** [DevOps Journey – Kubernetes Labs](https://github.com/gerardinhoo/Devops-Journey/tree/main/kubernetes_labs)
