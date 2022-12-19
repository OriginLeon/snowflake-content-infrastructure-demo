resource "snowflake_stage" "ACCOUNT_STAGE_AUTO" {
  name                = "ACCOUNT_STAGE_AUTO"
  url                 = "s3://snowflake-sdi-${var.environment}-raw/demo/account-tf/"
  database            = upper(var.database_name)
  schema              = upper(var.schema_name)
  file_format         = "TYPE = JSON NULL_IF = []"
  storage_integration = "SNOWFLAKE_${upper(var.environment)}_RAW_INTEGRATION"
}

