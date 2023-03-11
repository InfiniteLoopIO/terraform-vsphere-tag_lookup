terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = ">= 2.3.1"
    }
  }
}

provider "vsphere" {
  /*
  Using env vars for provider config
  $env:VSPHERE_USER
  $env:VSPHERE_PASSWORD
  $env:VSPHERE_SERVER
  $env:VSPHERE_ALLOW_UNVERIFIED_SSL
*/
}
