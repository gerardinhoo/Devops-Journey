# IAM → EC2 Role → S3 Read (Terraform Mini)

Provision a **least‑privilege IAM setup** with Terraform so an **EC2 instance** can **read from exactly one S3 bucket**—no writes—using a role and **instance profile** (no long‑lived keys).

```
EC2 instance → Instance Profile → IAM Role
                    │                 │
                    └── trusts EC2 ───┘
                         │
                 Policy: s3:ListBucket + s3:GetObject
                         on ONE bucket only
```

---

## What this repo/folder contains
- **Customer‑managed IAM policy** scoped to a single S3 bucket
- **IAM role** whose **trust policy** allows EC2 to assume it
- **Instance profile** so an EC2 instance can “wear” the role
- (Optional) **S3 object** (`hello.txt`) managed by Terraform to demo reads

> We reference an **existing bucket** by name (data source). Swap the name in `terraform.tfvars`.

---

## Prerequisites
- Terraform **>= 1.6**
- AWS provider **~> 6.x**
- Credentials available to Terraform (pick one):
  - `AWS_PROFILE=...` (**aws configure** on your laptop), **or**
  - an **instance role** attached to the machine running Terraform (lab/admin), **or**
  - **AWS SSO** profile.
- A bucket name you own (e.g., `gerard-devops-bucket-2025`) and a region (e.g., `us-east-2`).

---

## Quick start

1) **Vars file (example)**
Create `terraform.tfvars` (do **not** commit real values):
```hcl
region         = "us-east-2"
bucket_name    = "gerard-devops-bucket-2025"
project_suffix = "gerard"
```

2) **Init, plan, apply**
```bash
terraform init -upgrade
terraform fmt && terraform validate
terraform apply -auto-approve
```

This creates:
- IAM policy: `S3ReadOnly-<suffix>`
- Role: `ec2-s3-readonly-<suffix>`
- Instance profile: `ec2-s3-readonly-<suffix>`

3) **Attach the instance profile to your EC2**
EC2 Console → **Instances** → select your instance → **Actions → Security → Modify IAM role** → choose `ec2-s3-readonly-<suffix>` → **Save**.

---

## Test on the EC2 instance

Install AWS CLI v2 if needed (Amazon Linux):
```bash
curl -sS https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
sudo yum -y install unzip && unzip -q awscliv2.zip && sudo ./aws/install
```

Verify the assumed role & read access:
```bash
aws sts get-caller-identity
aws s3 ls s3://<your-bucket>
aws s3 cp s3://<your-bucket>/exercise4.js - | head   # or any existing object
```

Prove **least‑privilege** (write should fail):
```bash
echo denied > denied.txt
aws s3 cp denied.txt s3://<your-bucket>/denied.txt   # expect AccessDenied
```

---

Then apply:
```bash
terraform apply -auto-approve
```

Read it from the instance:
```bash
aws s3 cp s3://<your-bucket>/hello.txt -
```

> **What this resource does:** it **creates or updates** the S3 object with that key and content as part of Terraform state. If the `content` is changed and re‑apply, Terraform updates the object. On `terraform destroy`, the object is deleted (subject to bucket settings, e.g., versioning/lifecycle).

---

## Clean up
Before destroying IAM, role needs to be detached from any running instances (Console → Instance → **Modify IAM role** → **None**). Then:
```bash
terraform destroy -auto-approve
```

---

## Explanation of the project

- Implemented **least‑privilege IAM**: the EC2 instance can **only read** from a specific S3 bucket.
- Used **roles + instance profiles** for **temporary credentials**—no hard‑coded keys on servers.
- Wrote **Terraform** to provision IAM artifacts idempotently (policy docs, role trust, attachments).
- Validated with the AWS CLI: **allowed** reads, **denied** writes (intentional AccessDenied).

---

## Glossary (fast)
- **User**: human/app with long‑lived credentials (avoid on servers).
- **Role**: identity you **assume**; gets **temporary** creds (preferred).
- **Policy**: JSON **permissions** (actions + resources).
- **Trust policy**: who can **assume** the role (for EC2 roles: `ec2.amazonaws.com`).
- **Instance profile**: lets an EC2 instance wear a role.
- **IMDSv2**: metadata endpoint EC2 uses to fetch temporary creds for the role.

---

## Files to keep out of git
```
.terraform/
*.tfstate
*.tfstate.*
crash.log
terraform.tfvars
```
