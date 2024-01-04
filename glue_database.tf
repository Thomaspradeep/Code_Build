resource "aws_glue_catalog_database" "glue_credit_process_database" {
    name = "ddm_credit_process_${var.environment}"  
}

resource "aws_glue_catalog_database" "glue_credit_process_databases" {
    name = "credit_process_${var.environment}"  
}