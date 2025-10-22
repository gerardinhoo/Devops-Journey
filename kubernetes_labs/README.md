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

## Next (Phase 2 – Part 2)

- Persistent Volumes / Persistent Volume Claims / StorageClass.
- Mounting ConfigMaps/Secrets as files.
- StatefulSets vs Deployments; DaemonSets; CronJobs.
