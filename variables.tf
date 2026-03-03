variable "tenancy_ocid" {
  description = "Your tenancy OCID (root compartment)"
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaanu6q52rtxkgospl63a6wrr2qzxseeuk5wstbgbcfgoigphqhhbqa"
}

variable "atp_dbs" {
  description = "DBRE Multi-ATP"
  type = map(object({
    db_name = string
  }))
  default = {
    atp1 = { db_name = "DBREATP1" }
    atp2 = { db_name = "DBREATP2" }
  }
}
