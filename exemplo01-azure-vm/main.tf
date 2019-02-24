# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  #version = "1.22.1"
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "${var.resourcename}-rg"
    location = "${var.location}"

    tags {
        environment = "Terraform Azure Examples"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.resourcename}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Create subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${var.resourcename}-subnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix       = "10.0.1.0/24"
}

# Create public IP
resource "azurerm_public_ip" "publicip" {
    name                         = "${var.resourcename}-publicip"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    allocation_method            = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = "${var.resourcename}-nsg"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "${var.resourcename}-nic"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name                          = "${var.resourcename}-nic-config"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
    }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.resourcename}-vm01"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "Standard_B1s"

    storage_os_disk {
        name              = "${var.resourcename}-vm01-os-disk"
        resource_group_name   = "${azurerm_resource_group.rg.name}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.computer_name}"
        admin_username = "${var.admin_username}"
        admin_password = "${var.admin_password}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

}
