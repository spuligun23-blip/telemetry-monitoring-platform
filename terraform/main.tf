terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7c504eb1-7ac7-4b65-b176-58eca555b3d1"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-databricks-platform"
  location = "East US"
}

resource "azurerm_databricks_workspace" "prod" {
  name                          = "dbw-telemetry-prod"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "premium"
  public_network_access_enabled = true
}

resource "azurerm_databricks_workspace" "dev" {
  name                          = "dbw-telemetry-dev"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "premium"
  public_network_access_enabled = true
}

output "prod_url" {
  value = "https://${azurerm_databricks_workspace.prod.workspace_url}"
}

output "dev_url" {
  value = "https://${azurerm_databricks_workspace.dev.workspace_url}"
}