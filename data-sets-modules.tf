// EVENT-BASED DATA

module "account" {
  source                = "./data_sets/account"
  environment           = var.environment
  tasks_timeout         = local.tasks_timeout
  database_name         = local.default_db
  schema_name           = local.default_raw_schema
  snowflake_credentials = local.snowflake_credentials
}



