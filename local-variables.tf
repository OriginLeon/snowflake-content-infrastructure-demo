locals {

  snowflake_credentials = {
    account  = var.snowflake_account
    password = var.snowflake_password
    region   = var.snowflake_region
    username = var.snowflake_username
    role     = var.snowflake_role
  }

  default_db  = "RAW_DEMO_DB"
  default_raw_schema  = "EXAMPLE_SCHEMA"
  default_view_schema = "EXAMPLE_SCHEMA"
  tasks_timeout       = 65000

}
