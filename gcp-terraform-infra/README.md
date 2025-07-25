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
  - Boot disk (Debian image)
  - Public IP address
  - SSH tag for firewall access
  - Docker installed via `startup.sh` during boot

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

### 🔍 Why These Steps Matter

| Step                    | Purpose                                                               |
| ----------------------- | --------------------------------------------------------------------- |
| **Terraform IaC**       | Declaratively and reproducibly manage infrastructure                  |
| **Startup Script**      | Automatically configure VMs on boot (e.g., install Docker)            |
| **Outputs**             | Feed key data into pipelines or dashboards (IP, resource names, etc.) |
| **SSH Access**          | Verify and troubleshoot VM directly                                   |
| **Terraform Lock File** | Ensure consistent provider versions across environments               |

---

## ⏭️ What’s Next

We will now:

- 🔐 Store `terraform.tfstate` in a GCS bucket (remote backend)
- 🧱 Add Terraform workspaces for `dev` and `prod`
- 📈 Enable monitoring/logging with Stackdriver (and optionally Prometheus)

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

## 📌 Note

All work is version-controlled and committed as milestones are completed. This README tracks major infrastructure setup before CI/CD integration begins.

---

🗓️ Last Updated: July 25, 2025
