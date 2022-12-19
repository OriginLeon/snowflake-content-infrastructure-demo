resource "snowflake_task" "ACCOUNT_TABLE_TASK" {
  database  = upper(var.database_name)
  schema    = upper(var.schema_name)
  warehouse = "DEMO_WAREHOUSE"
  name      = "ACCOUNT_TABLE_TASK"
  schedule  = "1 MINUTE"
  sql_statement = <<-EOT
     CALL ${snowflake_procedure.ACCOUNT_TASK_PROCEDURE.database}.${snowflake_procedure.ACCOUNT_TASK_PROCEDURE.schema
}.${snowflake_procedure.ACCOUNT_TASK_PROCEDURE.name}
  (
    '${snowflake_table.ACCOUNT_TABLE.database}.${snowflake_table.ACCOUNT_TABLE.schema}.${snowflake_table.ACCOUNT_TABLE.name}'
  ,
    '${snowflake_stream.ACCOUNT_TABLE_STREAM.database}.${snowflake_stream.ACCOUNT_TABLE_STREAM.schema}.${snowflake_stream.ACCOUNT_TABLE_STREAM.name}'
  )
  EOT
user_task_timeout_ms = var.tasks_timeout
when                 = "SYSTEM$STREAM_HAS_DATA('${var.database_name}.${snowflake_stream.ACCOUNT_TABLE_STREAM.schema}.${snowflake_stream.ACCOUNT_TABLE_STREAM.name}')"
enabled              = true

}