resource "oci_core_vcn" "lab_vcn" {
  compartment_id = var.tenancy_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "terraform-lab-vcn"
  dns_label      = "labvcn"
}

# Add to main.tf (private subnet for DBs)
resource "oci_core_nat_gateway" "db_nat" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.lab_vcn.id
  display_name   = "dbre-lab-nat"
}

resource "oci_core_subnet" "db_private_subnet" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.lab_vcn.id
  cidr_block     = "10.0.10.0/24"
  display_name   = "dbre-db-private"
  prohibit_public_ip_on_vnic = true
  dns_label           = "dbpriv"  # ADD THIS (lowercase, 1-15 chars)
}



resource "oci_database_autonomous_database" "dbre_multi" {
  for_each = var.atp_dbs

  compartment_id = var.tenancy_ocid
  cpu_core_count = 1
  data_storage_size_in_tbs = 1
  db_name        = each.value.db_name
  display_name   = "DBRE-${each.key}"
  admin_password = "DBre2026##12"
  db_workload    = "OLTP"
  is_free_tier   = true
  license_model  = "LICENSE_INCLUDED"
}

# After dbre_multi block
resource "oci_database_autonomous_database_wallet" "dbre_wallets" {
  for_each = oci_database_autonomous_database.dbre_multi

  autonomous_database_id = each.value.id
  password               = "DBre2026##12"
  base64_encode_content  = true
}

output "wallet_base64" {
  value = { for k, v in oci_database_autonomous_database_wallet.dbre_wallets : k => v.content }
  sensitive = true
}
