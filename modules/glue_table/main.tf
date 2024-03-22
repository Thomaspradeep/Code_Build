resource "aws_glue_catalog_table" "client_table"{
    name = "mwt_${var.client_name}"
    database_name = var.glue_database_name
}