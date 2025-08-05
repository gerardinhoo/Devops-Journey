# 🚀 GCP Infrastructure Setup with Terraform

This project provisions and manages a complete infrastructure on **Google Cloud Platform** using **Terraform**, following real-world DevOps practices.

---

## ✅ What’s Been Done So Far

### 1. 🔧 Terraform Files Created

- **main.tf**: Core infrastructure setup (VPC, Subnet, Firewall, VM)
- **variables.tf**: Input variables for flexibility and reuse
- **terraform.tfvars**: Concrete values for the defined variables
- **startup.sh**: Provisioning script to install Docker (or any other app) during VM startup
- **outputs.tf**: Outputs to extract and display useful runtime data (external IPs, resource names, etc.)

---

### 2. 🌐 Infrastructure Provisioned on GCP

- **VPC** and **Subnet** created with custom CIDR block
- **Firewall** rule allowing SSH (TCP port 22)
- **VM Instance** with:
  - Boot disk (Ubuntu 22.04 LTS image)
  - Public IP address
  - SSH tag for firewall access
  - Docker and Git installed via startup.sh during boot
  - Verified via SSH (docker --version, git --version)

---

### 3. 🖥️ SSH into VM

- Used `gcloud compute ssh` to connect to VM securely
- Verified Docker was running inside the VM

---

### 4. 📤 Outputs

- External IP of VM
- VM instance name
- VPC and Subnet information

This allows for:

- Easier debugging and deployment references
- Integration with CI/CD pipelines

---

### 5. 🌱 Environment Isolation with Workspaces

We introduced Terraform workspaces to isolate deployments into distinct dev and prod environments.

Each environment provisions uniquely named resources by dynamically appending the workspace (dev, prod) to resource names.

🧠 Why Use Workspaces?

| Feature               | Benefit                                                |
| --------------------- | ------------------------------------------------------ |
| Environment isolation | Separate resources for dev and prod with shared config |
| Dynamic naming        | Automatically adds `-dev` or `-prod` to resource names |
| Reduced duplication   | Avoids maintaining separate Terraform files per env    |
| Easier testing        | Safely test changes in dev before promoting to prod    |

🛠️ Setup Summary

Resources dynamically named using terraform.workspace
name = "${var.vm_name}-${terraform.workspace}"

Each workspace writes its state to a separate prefix in a GCS backend:

gs://devops-terraform-state-bucket-gerard-20250725/gcp-terraform/dev/terraform.tfstate
gs://devops-terraform-state-bucket-gerard-20250725/gcp-terraform/prod/terraform.tfstate

🚀 Commands to Use Workspaces

### 6. List all available workspaces

- terraform workspace list

### 7. Create new workspaces (only once)

- terraform workspace new dev
- terraform workspace new prod

### 8. Switch between them

- terraform workspace select dev
- terraform apply # Applies to dev environment

- terraform workspace select prod
- terraform apply # Applies to prod environment

✅ Deployment Verified

Both environments were successfully applied and tested with the following outputs:

**Dev Output**:

- vm_name = "devops-vm-dev"
- vm_external_ip = "34.133.136.20"

**Prod Output**:

- vm_name = "devops-vm-prod"
- vm_external_ip = "34.63.125.105"

### 🔍 Why These Steps Matter

| Step                     | Purpose                                                               |
| ------------------------ | --------------------------------------------------------------------- |
| **Terraform IaC**        | Declaratively and reproducibly manage infrastructure                  |
| **Startup Script**       | Automatically configure VMs on boot (e.g., install Docker, git)       |
| **Outputs**              | Feed key data into pipelines or dashboards (IP, resource names, etc.) |
| **SSH Access**           | Verify and troubleshoot VM directly                                   |
| **Terraform Lock File**  | Ensure consistent provider versions across environments               |
| **Terraform Workspaces** | Isolate environments like `dev` and `prod` using dynamic naming       |

---

## ⏭️ What’s Next

We will now:

- ✅ Store `terraform.tfstate` in a GCS bucket (remote backend) - Done
- ✅ Add Terraform workspaces for `dev` and `prod` - Done

* - 📦 Refactor into reusable Terraform modules (VPC, Compute, Firewall)

- 📈 Enable monitoring/logging with Stackdriver (and optionally Prometheus)

* - 🛠️ Set up CI/CD with GitHub Actions (Terraform plan/apply)
* - 🧪 Add `tflint` and `terraform validate` checks
* - 🔐 Explore secrets management (Vault or GCP Secret Manager)

---

## 📁 Project Structure

```plaintext
gcp-terraform-infra/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── startup.sh
└── .terraform.lock.hcl
```

---

### 📌 Note

All work is version-controlled and committed as milestones are completed. This README tracks major infrastructure setup before CI/CD integration begins.

---

### 🏷️ Versioning

This milestone was tagged as:  
`v0.1.0 - Initial environment setup with dev/prod workspaces`

### 🧪 VM Setup Verification (August 5, 2025)

Successfully provisioned a Dev VM (`devops-vm-dev`) with:

- Ubuntu 22.04 LTS base image
- Docker and Git installed using a `startup.sh` script
- Verified:
  - Docker version 27.5.1
  - Git version 2.34.1
  - GitHub repo (`Devops-Journey`) cloned successfully
- SSH login tested using:
  ```bash
  ssh gcp-devops
  ```

🗓️ Last Updated: August 05, 2025
