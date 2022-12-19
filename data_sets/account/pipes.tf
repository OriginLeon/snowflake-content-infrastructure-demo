resource "snowflake_pipe" "ACCOUNT_PIPE" {
  database       = upper(var.database_name)
  schema         = upper(var.schema_name)
  name           = "ACCOUNT_PIPE"
  copy_statement = <<-EOF
    COPY INTO ${var.database_name}.${snowflake_table.ACCOUNT_LANDING_TABLE.schema}.${snowflake_table.ACCOUNT_LANDING_TABLE.name}
      (ID, JSON, TYPE, FILENAME, EVENT_UPDATE)
      FROM (
        SELECT $1:data:id, $1,
        CASE $1:action
          WHEN 'Account.deleted' THEN 'DELETE'
          WHEN 'Account.created' THEN 'INSERT'
          ELSE 'UPDATE'
        END,
        SPLIT_PART(METADATA$FILENAME, '/', 3), CURRENT_TIMESTAMP
      FROM @${var.database_name}.${snowflake_stage.ACCOUNT_STAGE_AUTO.schema}.${snowflake_stage.ACCOUNT_STAGE_AUTO.name});
  EOF
  auto_ingest    = true
}
