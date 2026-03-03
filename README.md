🚀 DBRE OCI Terraform Lab

OCI Free Tier Multi-ATP Terraform Lab for Database Reliability Engineering (DBRE)
Region: ap-hyderabad-1

🏗 Architecture Overview
OCI Free Tier (ap-hyderabad-1)
│
├── Compartment: Root/Tenancy
│
├── 2x Always Free ATP Databases
│   ├── DBREATP1 (1 OCPU, 20GB, OLTP)
│   └── DBREATP2 (1 OCPU, 20GB, OLTP)
│
├── Terraform State: Local
│   (Production: OCI Object Storage Backend)
│
└── Connectivity:
    ├── Wallet
    ├── SQLcl
    └── OCI CLI
    
✨ Features
Feature	Status	Description
Multi-ATP	✅ Live	for_each pattern scales to N databases
Wallet Automation	✅	oci_database_autonomous_database_wallet
Free Tier Optimized	✅	Max 2 Always Free ATPs
DBRE Workflows	✅	Destroy/Recreate, State Backup/Restore
OCI Hyderabad	✅	Regional deployment (ap-hyderabad-1)

📋 Prerequisites
1️⃣ OCI CLI Configured
oci session authenticate --region ap-hyderabad-1
2️⃣ Terraform 1.9+
terraform version
3️⃣ SQLcl (Optional – for connectivity test)
sql admin_password@DBREATP1_high
🔧 Environment Variables

Add your tenancy OCID:

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..your_tenancy_ocid"

⚡ Quickstart
git clone https://github.com/kalyanmurala-git/dbre-oci-terraform-lab
cd dbre-oci-terraform-lab
Initialize
terraform init
Plan
terraform plan
# Expected: +2 ATPs, +2 Wallets
Apply
terraform apply
# ~10 minutes provisioning time

📤 Outputs & Verification
Get Database OCID
terraform state show 'oci_database_autonomous_database.dbre_multi["atp1"]'
Console Verification
OCI Console → Database → DBRE-atp1 / DBRE-atp2
Status: Available ✅

🔐 Connectivity Test
Download Wallet
Console → Database → DB Connection → Wallet
Connect Using SQLcl
export TNS_ADMIN=~/dbre_atp1_wallet
sql admin/Password@DBREATP1_high
SELECT name FROM v$database;
-- Expected: DBREATP1

🧪 DBRE Test Scenarios
🔁 PITR Simulation
terraform destroy
terraform apply

(Backup restore validation)

📈 Scale Test

Add new entry in atp_dbs map:

atp3 = {
  display_name = "DBREATP3"
}
terraform plan

⚠ Free Tier quota will limit to 2 ATPs.

🌍 DR (Paid Feature)

Cross-region clone

Backup-based restore

📡 Monitoring Automation

OCI Events

DB patching automation

Notifications integration

📁 Repository Structure
├── main.tf          # ATP + Wallet resources
├── variables.tf     # atp_dbs map configuration
├── provider.tf      # OCI provider (6.37.0)
├── .gitignore       # tfstate protection
├── README.md        # Documentation
└── LICENSE          # MIT

🏢 Production Extensions
Area	Enhancement
CI/CD	GitHub Actions → terraform plan/apply
State	OCI Object Storage Backend
Monitoring	OCI Notifications
Kubernetes	CloudNativePG Operator
MLOps	OCI Data Science Integration

👨‍💻 Author

Kalyan Murala
Senior Database Reliability Engineer

15+ Years Experience
Oracle | Exadata | OCI | AWS | Kubernetes | MLOps

