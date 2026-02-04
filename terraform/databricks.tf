provider "databricks" {
  alias                       = "prod"
  host                        = "https://${azurerm_databricks_workspace.prod.workspace_url}"
  azure_workspace_resource_id = azurerm_databricks_workspace.prod.id
}

provider "databricks" {
  alias                       = "dev"
  host                        = "https://${azurerm_databricks_workspace.dev.workspace_url}"
  azure_workspace_resource_id = azurerm_databricks_workspace.dev.id
}

# PROD Resources
resource "databricks_group" "engineers_prod" {
  provider                 = databricks.prod
  display_name             = "Data-Engineers"
  allow_cluster_create     = true
  databricks_sql_access    = true
}

resource "databricks_service_principal" "cicd_prod" {
  provider       = databricks.prod
  application_id = "a57e36cd-001d-4ed1-897c-ffdd62bb20ea"
  display_name   = "cicd-deployer"
}

resource "databricks_group_member" "sp_prod" {
  provider  = databricks.prod
  group_id  = databricks_group.engineers_prod.id
  member_id = databricks_service_principal.cicd_prod.id
}

# DEV Resources
resource "databricks_group" "developers" {
  provider                 = databricks.dev
  display_name             = "Developers"
  allow_cluster_create     = true
  databricks_sql_access    = true
  workspace_access         = true
}

resource "databricks_service_principal" "cicd_dev" {
  provider       = databricks.dev
  application_id = "a57e36cd-001d-4ed1-897c-ffdd62bb20ea"
  display_name   = "cicd-deployer"
}

resource "databricks_group_member" "sp_dev" {
  provider  = databricks.dev
  group_id  = databricks_group.developers.id
  member_id = databricks_service_principal.cicd_dev.id
}