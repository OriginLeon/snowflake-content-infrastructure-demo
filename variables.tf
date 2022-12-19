
variable "snowflake_username" {
  type        = string
  description = "Username for Snowflake authentication"
}

variable "snowflake_account" {
  type        = string
  description = "Account for Snowflake authentication"
}

variable "snowflake_region" {
  type        = string
  description = "Region for Snowflake authentication"
}

variable "snowflake_password" {
  type        = string
  description = "Password for Snowflake authentication"
}

variable "snowflake_role" {
  type        = string
  description = "Default role to execute Snowflake changes"
}

variable "team_name" {
  type        = string
  description = "The name of the team that owns this application, i.e. core, captive-portal, or network-management"
  default     = "reporting"
}

variable "application_name" {
  type        = string
  description = "The name of the application, i.e. network-discovery, or console-app-web"
  default     = "snowflake-po-account-mgmt"
}

variable "environment" {
  type        = string
  description = "The name of the environment that is currently being deployed to, i.e. staging or production"
}
