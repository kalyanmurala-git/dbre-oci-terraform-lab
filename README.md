# dbre-oci-terraform-lab
OCI Free Tier Multi-ATP Terraform Lab for Database Reliability Engineering (DBRE). 

# OCI DBRE Terraform Lab: Multi-ATP Provisioning

****Infrastructure as Code (IaC)** for **Oracle Cloud Infrastructure (OCI) Always Free Tier** - provisioning **2 Autonomous Transaction Processing (ATP)** databases using **Terraform `for_each`** pattern.**

OCI Free Tier (ap-hyderabad-1)
├── Compartment: Root/Tenancy
├── 2x Always Free ATP Databases
│ ├── DBREATP1 (1 OCPU, 20GB, OLTP)
│ └── DBREATP2 (1 OCPU, 20GB, OLTP)
├── Terraform State: Local (Production: OCI OSS)
└── Connectivity: Wallet + sqlcl/OCI CLI


## ✨ Features

| Feature | Status | Description |
|---------|--------|-------------|
| Multi-ATP | ✅ Live | `for_each` pattern scales to N databases |
| Wallet Automation | ✅ | `oci_database_autonomous_database_wallet` |
| Free Tier Optimized | ✅ | 2x max ATPs (no scale/upgrade needed) |
| DBRE Workflows | ✅ | Destroy/recreate, state backup/restore |
| OCI Hyderabad | ✅ | Regional deployment (ap-hyderabad-1) |

1.  Prerequisites

# OCI CLI configured
oci session authenticate --region ap-hyderabad-1

# Terraform 1.9+
terraform version

# sqlcl (optional)
sql admin_password@DBREATP1_high

Variables (variables.tf):
TF_VAR_tenancy_ocid = "ocid1.tenancy.oc1..your_tenancy_ocid"

2.  Quickstart

git clone https://github.com/kalyanmurala-git/dbre-oci-terraform-lab
cd dbre-oci-terraform-lab

# Configure tenancy_ocid
terraform init
terraform plan    # +2 ATPs, +2 Wallets
terraform apply   # ~10min provisioning


3.  Outputs & Verification

# Database OCIDs
terraform state show 'oci_database_autonomous_database.dbre_multi["atp1"]'

# Console Verification
OCI Console → Database → DBRE-atp1, DBRE-atp2 → Available ✅


4. Connectivity:

bash
# Download Wallet (Console: Database → DB Connection → Wallet)
export TNS_ADMIN=~/dbre_atp1_wallet
sql admin/Password@DBREATP1_high
SQL> SELECT name FROM v$database;  -- DBREATP1


5.  DBRE Test Scenarios

1. PITR: terraform destroy → apply = backup restore
2. Scale Test: Add atp3 to map → plan (quota limit)
3. DR: Cross-region clone (paid)
4. Monitoring: OCI Events → DB patching automation


6. Repository Structure

├── main.tf              # ATP + Wallet resources
├── variables.tf         # atp_dbs map configuration
├── provider.tf          # OCI provider 6.37.0
├── .gitignore           # tfstate protection
├── README.md           # This document
└── LICENSE             # MIT

7.  Production Extensions

CI/CD: GitHub Actions → terraform plan/apply
State: OCI OSS backend (team sharing)
Monitoring: OCI Notifications → ATP patching
Kubernetes: CNPG operator (next lab)
MLOps: OCI Data Science integration


📈 Author
Kalyan Murala
Senior Database Reliability Engineer
15+ Years: Oracle | Exadata | OCI | AWS | Kubernetes | MLOps

