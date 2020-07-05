# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

resource "azurerm_resource_group" "javasql" {
 name     = var.resource_group_name
 location = var.location
 tags     = var.tags
}

resource "azurerm_app_service_plan" "javasql" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.javasql.location
  resource_group_name = azurerm_resource_group.javasql.name

    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "javasql" {
  name                = var.app_service_name
  location            = azurerm_resource_group.javasql.location
  resource_group_name = azurerm_resource_group.javasql.name
  app_service_plan_id = azurerm_app_service_plan.javasql.id
  
  site_config {
    java_version            = "1.8"
    java_container          = "TOMCAT"
    java_container_version  = "9.0"
  }

  connection_string {
    name  = "MyShuttleDb"
    type  = "MySQL"
    value = "jdbc:mysql://myshuttleserver2021.mysql.database.azure.com:3306/alm?useSSL=true&requireSSL=false&autoReconnect=true&user=mysqldbuser@myshuttleserver2021&password=P2ssw0rd@123"
  }
}

resource "azurerm_mysql_server" "javasql" {
  name                = var.sql_server_name
  location            = azurerm_resource_group.javasql.location
  resource_group_name = azurerm_resource_group.javasql.name

  administrator_login          = "mysqldbuser"
  administrator_login_password = "P2ssw0rd@123"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"
  ssl_enforcement_enabled           = false
}

resource "azurerm_mysql_firewall_rule" "javasql" {
  name                = "AzureServicesAllow"
  resource_group_name = azurerm_resource_group.javasql.name
  server_name         = azurerm_mysql_server.javasql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
