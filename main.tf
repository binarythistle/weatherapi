provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_storage"
        storage_account_name = "tfsabinarythistle"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name      = "tfrgmain"
  location  = "Australia East"
}

resource "azurerm_container_group" "tf_test_az_cg" {
    name                = "weatherapi_terra"
    location            = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name
    ip_address_type     = "public"
    dns_name_label      = "binarythistleapiterra"
    os_type             =  "Linux"

    container {
        name            = "weatherapi"
        image           = "binarythistle/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
    }
}