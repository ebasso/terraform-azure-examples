# You'll usually want to set this to a region near you.
variable "location" {
    default = "eastus"
}
variable "resourcename" {
  default = "tf-az-example03"
}
variable "computer_name" {
    default = "example02-vm01"
}
variable "admin_username" {
    default = "spock"
}
variable "admin_password" {
    default = "admin@123"
}

variable "environment" {
    default = "dev"
}
variable "vm_size" {
    default = {
        "dev"   = "Standard_B2s"
        "prod"  = "Standard_D2s_v3"
    }
}

