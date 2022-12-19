terraform {
  required_version = "~> 1.0"

  required_providers {
    snowflake = {
      source  = "snowflake-labs/snowflake"
      version = ">= 0.37.0"
    }
  }

}

provider "snowflake" {
  username = var.snowflake_credentials.username
  account  = var.snowflake_credentials.account
  region   = var.snowflake_credentials.region
  password = var.snowflake_credentials.password
  role     = var.snowflake_credentials.role
}

