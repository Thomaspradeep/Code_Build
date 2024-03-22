resource "aws_glue_catalog_database" "glue_credit_process_database" {
    name = "ddm_credit_process_${var.environment}"
    create_table_default_permission {
    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }
}

resource "aws_glue_catalog_database" "glue_credit_process_databases" {
    name = "credit_process_${var.environment}"  
}

# resource "aws_lakeformation_permissions" "example" {
#   principal   = "arn:aws:iam::941598205732:role/lakeformation"
#   permissions = ["CREATE_TABLE", "ALTER", "DROP"]
#   database {
#     name       = aws_glue_catalog_database.glue_credit_process_database.name
#   }
# }

# resource "aws_glue_catalog_database" "glue_credit_process_databases_test"{
#     name = "credit_process_test_${var.environment}"  
# }

module "m3_clients" {
  source = "./modules/glue_table"
  for_each = var.clients_list
  client_name = each.key
  glue_database_name = aws_glue_catalog_database.glue_credit_process_database.name
}