resource "snowflake_view" "ACCOUNTS_VIEW" {
  database   = var.database
  schema     = var.schema
  name       = "ACCOUNTS_VIEW"
  statement  = <<-EOT
    SELECT
    ID,
    JSON:data:attributes:name::varchar AS NAME,
    JSON:data:attributes:vertical::varchar AS VERTICAL,
    JSON:data:attributes:subVertical::varchar AS SUB_VERTICAL
    FROM ${var.PO_ACCOUNTS_TABLE}
  EOT
  or_replace = true
  is_secure  = false
}
