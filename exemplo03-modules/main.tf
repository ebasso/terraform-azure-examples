/*
* Demonstrate use of provisioner 'file', 'remote-exec' to execute a command
* on a new VM instance.
*/

# Configure the provider.
provider "azurerm" {
#    version = "=1.20.0"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "${var.resourcename}-rg"
    location = "${var.location}"

    tags {
        environment = "Terraform Azure Example 03"
    }
}

# Use the network module to create a vnet and subnet
module "network" {
    source              = "Azure/network/azurerm"
    version             = "2.0.0"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    address_space       = "10.0.0.0/16"
    subnet_names        = ["${var.resourcename}-subnet"]
    subnet_prefixes     = ["10.0.1.0/24"]
}

# Use the compute module to create the VM
module "compute" {
    source            = "Azure/compute/azurerm"
    version           = "1.2.0"
    location          = "${var.location}"
    vnet_subnet_id    = "${element(module.network.vnet_subnets, 0)}"
    admin_username    = "${var.admin_username}"
    admin_password    = "${var.admin_password}"
    remote_port       = "22"
    vm_os_simple      = "UbuntuServer"
    vm_size           = "${lookup(var.vm_size, var.environment)}"
    public_ip_dns     = ["zzdns"]
}