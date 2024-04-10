module d2_client_perm_set {
source = "./modules/perm_set"
for_each = var.clients_list
client_name = each.key
instance_arn = var.instance_arn
account_id = var.account_id

providers = {
    aws = aws.mgmt
}
}