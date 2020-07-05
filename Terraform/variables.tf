variable "resource_group_name" {
    type =string
    default ="myShuttleRG2"
}

variable "location" {
    type =string
    default ="eastus"
}

variable "tags" {
    type =map(string)
    
    default = {
        environment = "javasql Demo"
    }
}

variable "app_service_plan_name" {
    type =string
    default ="MyPlan"
}

variable "app_service_name" {
    type =string
    default = "MyShuttleApp2021"
}

variable "sql_server_name" {
    type =string
    default ="myshuttleserver2021"
}