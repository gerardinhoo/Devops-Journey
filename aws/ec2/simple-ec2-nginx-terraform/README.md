# Simple EC2 + Nginx with Terraform (Amazon Linux 2023)

Spin up a tiny EC2 instance in the **default VPC**, open **SSH (22)** and **HTTP (80)**, and bootstrap **Nginx** with a custom page using **User Data**. Clean, minimal, and perfect for learning EC2 + Terraform fundamentals.

---

## Takeaways

- **EC2 provisioning with Terraform**: `plan` → `apply` → `destroy` lifecycle.
- **AMI discovery** with `data "aws_ami"` (Amazon Linux 2023).
- **Security Groups**: allow inbound 22/80 and all egress.
- **User Data (cloud-init)** to configure the instance at first boot (install Nginx, write `index.html`).
- **Default VPC** usage to keep the networking simple.
- **Tags & Outputs** for good hygiene and quick verification.
- **Credentials patterns**: run Terraform with a **role on the tools box** (IMDS) or a named **AWS CLI profile**.
- **Troubleshooting skills**: invalid credentials (`InvalidClientTokenId`), missing HTTP rule, AL2023 vs AL2 package differences, IMDS vs public IP.

---

## Project structure

```
aws/ec2/simple-ec2-nginx-terraform/
├─ versions.tf        # Provider pins
├─ variables.tf       # Inputs (region, instance_type, key_name, project)
├─ main.tf            # SG + AMI + EC2 + User Data
├─ outputs.tf         # Public IP & URL
└─ terraform.tfvars.example
```

> Tip: also add a repo-level `.gitignore` to avoid committing `*.tfstate` files.

```gitignore
**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
override.tf
override.tf.json
*.tfplan
```

---

## Prerequisites

- Terraform CLI `>= 1.6`
- AWS credentials available to the shell running Terraform:
  - **Best**: Run on an EC2 “tools” instance with an **IAM role** attached (IMDS), _or_
  - Use `aws configure --profile YOURPROFILE` and `export AWS_PROFILE=YOURPROFILE`

---

## Quick start

1. **Copy variables file** and edit as needed:

```bash
cp terraform.tfvars.example terraform.tfvars
# edit region / instance_type / key_name
```

2. **Init & apply**:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

3. **Open the URL** from the outputs and you should see the Nginx page.

4. **Clean up** when done:

```bash
terraform destroy -auto-approve
```

---

## Variables

| Name            | Type   | Default         | Description                           |
| --------------- | ------ | --------------- | ------------------------------------- |
| `region`        | string | `us-east-2`     | AWS region                            |
| `instance_type` | string | `t2.micro`      | EC2 instance type                     |
| `key_name`      | string | `""`            | Existing EC2 key pair name (optional) |
| `project`       | string | `ec2-nginx-lab` | Tagging prefix                        |

`terraform.tfvars.example`:

```hcl
region        = "us-east-2"
instance_type = "t2.micro"
key_name      = ""         # set to an existing key to enable SSH, or leave blank for EC2 Instance Connect
project       = "ec2-nginx-lab"
```

---

## How it works

- **AMI**: Uses a data source to grab the latest **Amazon Linux 2023** (x86_64) AMI owned by Amazon.
- **Security Group**: Allows inbound **22** (SSH) & **80** (HTTP) from anywhere; allows all egress.
- **User Data**: At first boot, it runs a script to install **nginx**, enable/start the service, and write a custom `/usr/share/nginx/html/index.html` page.
- **Outputs**: Print the instance’s public IP and a browser-friendly URL.

---

## Troubleshooting

- **`InvalidClientTokenId` / 403 from STS**  
  Your shell has bad or expired AWS creds. If running on an EC2 tools box, attach an **IAM role** to the instance and clear env overrides:

  ```bash
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_PROFILE
  aws sts get-caller-identity
  ```

  IMDS (instance role) is reachable only via `http://169.254.169.254` **from inside the instance**.

- **Browser times out**  
  Ensure the Security Group has inbound `HTTP (80)` from `0.0.0.0/0`, and nginx is running:

  ```bash
  sudo systemctl status nginx
  curl http://localhost
  ```

- **Wrong user data for AL2023 vs AL2**  
  AL2023 uses `dnf` + `nginx`. AL2 typically uses `yum` + `httpd` (Apache).

- **No default VPC**  
  This project expects a **default VPC** in the selected region. If your account doesn’t have one, either create it or modify `main.tf` to reference a specific VPC/subnet.

---

## Next steps (optional enhancements)

- **Elastic IP**: allocate & associate for a stable public IP.
- **IAM role for the workload**: attach `AmazonS3ReadOnlyAccess` to the EC2 and test `aws s3 ls` without keys.
- **CloudWatch alarm**: CPU > 70% with SNS notification.
- **Bake an AMI**: Packer image with nginx pre-installed for faster boot.

---

## Learn more (key commands)

```bash
# Terraform workflow
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

# Nginx checks (SSH into instance)
sudo systemctl status nginx
curl http://localhost
sudo journalctl -u nginx --no-pager -n 50
```

---

## Security & cost

- This example opens port **80** to the world for demo purposes. Restrict IPs in production.
- Running EC2 may incur a small cost if you’re outside the free tier; **destroy** when finished.
