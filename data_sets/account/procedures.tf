resource "snowflake_procedure" "ACCOUNT_TASK_PROCEDURE" {
  name     = "ACCOUNT_TASK_PROCEDURE"
  database = upper(var.database_name)
  schema   = upper(var.schema_name)
  language = "JAVASCRIPT"

  arguments {
    name = "PROC_ACCOUNT_TABLE"
    type = "VARCHAR"
  }

  arguments {
    name = "PROC_ACCOUNT_STREAM"
    type = "VARCHAR"
  }

  comment         = "Procedure with 2 arguments"
  return_type     = "VARCHAR"
  execute_as      = "CALLER"
  return_behavior = "IMMUTABLE"
  statement       = file("data_sets/account/procedure_files/account_task_proc.js")
}
