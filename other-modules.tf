
module "views" {
  source                = "./views"
  database              = "RAW_DEMO_DB"
  schema                = local.default_view_schema
  snowflake_credentials = local.snowflake_credentials
  PO_ACCOUNTS_TABLE     = module.account.PO_ACCOUNTS_TABLE
}
