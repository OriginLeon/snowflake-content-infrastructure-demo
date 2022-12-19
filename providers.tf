
terraform {
  required_version = "~> 1.0"

  /*
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "my-organization"

    workspaces {
      prefix = "my-workspace-"
    }
  }
  */

  required_providers {
    snowflake = {
      source  = "snowflake-labs/snowflake"
      version = "= 0.40.0"
    }
  }
}

provider "snowflake" {
  username = var.snowflake_username
  account  = var.snowflake_account
  region   = var.snowflake_region
  password = var.snowflake_password
  role     = var.snowflake_role
}
