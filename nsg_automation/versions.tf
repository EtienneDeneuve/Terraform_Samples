provider "azurerm" {
  version = "=2.0.0"
  features {}
}



terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    subscription_id      = "f669b09b-bb47-484f-9b3a-cc884c3328b7"
    resource_group_name  = "NE-ITG-RG-STATE-RPA"
    storage_account_name = "remotestaterpa"
    container_name       = "dev-2"
    key                  = "c8dUBpqLNTxuJG40NfSL6YAVfDiaPgE+2m/Ho1Q0TfU6H2gBODey1i7EnUzCVO5tpEgPIyK/8OdGHrlxu6bBQA=="
  }
}
