module "wrapper" {
  source = "../"

  for_each = var.items

  use_existing_service_account = try(each.value.use_existing_service_account, var.defaults.use_existing_service_account, false)
  service_account_name         = try(each.value.service_account_name, var.defaults.service_account_name)
  namespace                    = try(each.value.namespace, var.defaults.namespace)
  cluster_name                 = try(each.value.cluster_name, var.defaults.cluster_name)
  role_name                    = try(each.value.role_name, var.defaults.role_name)
  tags                         = try(each.value.tags, var.defaults.tags, {})
}
