module "d3_credit_clients" {
    source = "./modules/cds_client"
    for_each = var.credit_clients_list

    client_name = each.key
    client_map = each.value

    providers = {
        aws = aws
    }
}