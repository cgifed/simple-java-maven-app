resource_group = "github-actions-demo"
prefix = "gha"
location = "eastus2"
vm_size = "Standard_DC1ds_v3"
computer_name = "gha"
key_vault_name = "github-actions-demo-kv"
key_vault_secret_name = "vm-password"
tags = {
    "environment" = "Prod"
    "project" = "gha"
}
