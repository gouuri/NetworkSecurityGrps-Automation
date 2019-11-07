provider "azurerm" {
  version = "=1.22.0"
  tenant_id = "425132e4-ceff-47ec-991d-06890a943af3" # Static
  skip_provider_registration = true

}

terraform {
  backend "azurerm" {
    storage_account_name = "69d3xxsaxxaz1xx01"
    container_name = "tfstate"
    key = "preprod/network-security-groups/tfstate"

    access_key = "njdS1X3GN4aW124ouKmj3ftr6H4WBUeCwYkMIsrliAL1JS0NKzrzrQgJtbB8jcw=="
  }
