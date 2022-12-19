resource "snowflake_stream" "ACCOUNT_TABLE_STREAM" {
  database    = upper(var.database_name)
  schema      = upper(var.schema_name)
  name        = "ACCOUNT_TABLE_STREAM"
  on_table    = "${var.database_name}.${snowflake_table.ACCOUNT_LANDING_TABLE.schema}.${snowflake_table.ACCOUNT_LANDING_TABLE.name}"
  append_only = true
}
