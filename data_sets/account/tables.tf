resource "snowflake_table" "ACCOUNT_LANDING_TABLE" {
  database        = upper(var.database_name)
  schema          = upper(var.schema_name)
  name            = "ACCOUNT_LANDING_TABLE"
  comment         = "ACCOUNT_LANDING table from ${upper(var.schema_name)} Event"
  change_tracking = true

  column {
    name = "ID"
    type = "VARCHAR(16777216)"
  }

  column {
    name = "JSON"
    type = "VARIANT"
  }

  column {
    name = "TYPE"
    type = "VARCHAR(16777216)"
  }

  column {
    name = "FILENAME"
    type = "VARCHAR(16777216)"
  }

  column {
    name = "EVENT_UPDATE"
    type = "TIMESTAMP_NTZ(9)"
  }

}

resource "snowflake_table" "ACCOUNT_TABLE" {
  database = upper(var.database_name)
  schema   = upper(var.schema_name)
  name     = "ACCOUNT_TABLE"
  comment  = "ACCOUNT table from ${upper(var.schema_name)} Event"

  column {
    name = "ID"
    type = "VARCHAR(16777216)"
  }

  column {
    name = "JSON"
    type = "VARIANT"
  }

  column {
    name = "RECORD_UPDATE"
    type = "TIMESTAMP_NTZ(9)"
  }

  column {
    name = "DELETED_TIMESTAMP"
    type = "TIMESTAMP_NTZ(9)"
  }

}
