locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Akash.Patel"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "resource_group" {
  source                     = "./assignment1-n01569982/rgroup-n01569982"
  resource_group_name_prefix = var.humber_id
  location                   = var.location
  tags                       = local.tags
}

module "network" {
  source                     = "./assignment1-n01569982/network-n01569982"
  resource_group_name        = module.resource_group.resource_group_name
  vnet_name_prefix           = var.humber_id
  subnet_name_prefix         = var.humber_id
  security_group_name_prefix = var.humber_id
  location                   = var.location
  tags                       = local.tags
}

module "common" {
  source              = "./assignment1-n01569982/common-n01569982"
  resource_group_name = module.resource_group.resource_group_name
  name_prefix         = var.humber_id
  location            = var.location
  tags                = local.tags
}

module "linux_vm" {
  source                             = "./assignment1-n01569982/vmlinux-n01569982"
  resource_group_name                = module.resource_group.resource_group_name
  vm_count                           = 3
  vm_name_prefix                     = "vm-c-n01569982"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  vmlinux_key_path                   = "~/.ssh/id_rsa.pub"
  vmlinux_priv_key_path              = "~/.ssh/id_rsa"
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  location                           = var.location
  tags                               = local.tags
}

module "win_vm" {
  source                             = "./assignment1-n01569982/vmwindows-n01569982"
  resource_group_name                = module.resource_group.resource_group_name
  vm_count                           = 1
  vm_name_prefix                     = "vm-w-n01569982"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  admin_username                     = "akash"
  admin_password                     = "Monday1?"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  location                           = var.location
  tags                               = local.tags
}

module "data_disk" {
  source              = "./assignment1-n01569982/datadisk-n01569982"
  disk_count          = 4
  disk_size_gb        = 10
  resource_group_name = module.resource_group.resource_group_name
  vm_ids              = concat(module.linux_vm.vm_ids, module.win_vm.vm_ids)
  location            = var.location
  tags                = local.tags
}

module "lb" {
  source              = "./assignment1-n01569982/loadbalancer-n01569982"
  resource_group_name = module.resource_group.resource_group_name
  nic_id              = module.linux_vm.nic_ids
  ip_config           = module.linux_vm.ip_config_ids
  location            = var.location
  tags                = local.tags
}

module "db" {
  source              = "./assignment1-n01569982/database-n01569982"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  tags                = local.tags
}