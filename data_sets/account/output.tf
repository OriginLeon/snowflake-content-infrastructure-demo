output "PO_ACCOUNTS_TABLE" {
  value = "${snowflake_table.ACCOUNT_TABLE.database}.${snowflake_table.ACCOUNT_TABLE.schema}.${snowflake_table.ACCOUNT_TABLE.name}"
}
