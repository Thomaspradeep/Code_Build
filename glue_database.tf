resource "aws_glue_catalog_database" "glue_credit_process_database" {
    name = "ddm_credit_process_${var.environment}" 
    create_table_default_permission {
        permissions = ["SELECT"]
        principal {
          data_lake_principal_identifier = 
        }
    }
}

resource "aws_glue_catalog_database" "glue_credit_process_databases" {
    name = "credit_process_${var.environment}"  
}