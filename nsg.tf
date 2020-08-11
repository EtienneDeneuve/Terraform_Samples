
variable "filePath" {
  default = "deploy/module/nsg/"
}

variable "nsg_name" {}
variable "tags" {}
variable "vm_usage" {}
variable "rg_name" {}
variable "rg_location" {}

resource "azurerm_resource_group" "tf-rg" {
  name     = join("-", [var.rg_name, var.vm_usage])
  location = var.rg_location
  tags     = var.tags
}

locals {
  default_content = <<-CSV
  "Name","Description","Priority","Protocol","Access","Direction","SourceAddressPrefix","SourcePortRange","DestinationAddressPrefix","DestinationPortRange"
CSV

  # rules        = csvdecode(local.default)
  default_0000 = fileexists("${path.module}/csv-name0000.csv") ? file("${path.module}/csv-name0000.csv") : local.default_content
  default_0001 = fileexists("${path.module}/csv-name0001.csv") ? file("${path.module}/csv-name0001.csv") : local.default_content
  default_0010 = fileexists("${path.module}/csv-name0010.csv") ? file("${path.module}/csv-name0010.csv") : local.default_content
  default_0011 = fileexists("${path.module}/csv-name0011.csv") ? file("${path.module}/csv-name0011.csv") : local.default_content
  default_0100 = fileexists("${path.module}/csv-name0100.csv") ? file("${path.module}/csv-name0100.csv") : local.default_content
  default_0101 = fileexists("${path.module}/csv-name0101.csv") ? file("${path.module}/csv-name0101.csv") : local.default_content
  default_0110 = fileexists("${path.module}/csv-name0110.csv") ? file("${path.module}/csv-name0110.csv") : local.default_content
  default_0111 = fileexists("${path.module}/csv-name0111.csv") ? file("${path.module}/csv-name0111.csv") : local.default_content
  default_1000 = fileexists("${path.module}/csv-name1000.csv") ? file("${path.module}/csv-name1000.csv") : local.default_content
  default_1001 = fileexists("${path.module}/csv-name1001.csv") ? file("${path.module}/csv-name1001.csv") : local.default_content
  default_1010 = fileexists("${path.module}/csv-name1010.csv") ? file("${path.module}/csv-name1010.csv") : local.default_content
  default_1011 = fileexists("${path.module}/csv-name1011.csv") ? file("${path.module}/csv-name1011.csv") : local.default_content
  default_1100 = fileexists("${path.module}/csv-name1100.csv") ? file("${path.module}/csv-name1100.csv") : local.default_content
  default_1101 = fileexists("${path.module}/csv-name1101.csv") ? file("${path.module}/csv-name1101.csv") : local.default_content
  default_1110 = fileexists("${path.module}/csv-name1110.csv") ? file("${path.module}/csv-name1110.csv") : local.default_content
  default_1111 = fileexists("${path.module}/csv-name1111.csv") ? file("${path.module}/csv-name1111.csv") : local.default_content

  rules_0000 = csvdecode(local.default_0000)
  rules_0001 = csvdecode(local.default_0001)
  rules_0010 = csvdecode(local.default_0010)
  rules_0011 = csvdecode(local.default_0011)
  rules_0100 = csvdecode(local.default_0100)
  rules_0101 = csvdecode(local.default_0101)
  rules_0110 = csvdecode(local.default_0110)
  rules_0111 = csvdecode(local.default_0111)
  rules_1000 = csvdecode(local.default_1000)
  rules_1001 = csvdecode(local.default_1001)
  rules_1010 = csvdecode(local.default_1010)
  rules_1011 = csvdecode(local.default_1011)
  rules_1100 = csvdecode(local.default_1100)
  rules_1101 = csvdecode(local.default_1101)
  rules_1110 = csvdecode(local.default_1110)
  rules_1111 = csvdecode(local.default_1111)
}

resource "azurerm_network_security_group" "tf-nsg" {
  location            = azurerm_resource_group.tf-rg.location
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.tf-rg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.tf-nsg.id
}

output "rg_name" {
  value = azurerm_resource_group.tf-rg.name
}
output "rg_location" {
  value = azurerm_resource_group.tf-rg.location
}

resource "azurerm_network_security_rule" "rules_0000" {
  for_each                    = { for inst in local.rules_0000 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_range           = each.value.SourcePortRange
  destination_port_range      = each.value.DestinationPortRange
  source_address_prefix       = each.value.SourceAddressPrefix
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0001" {
  for_each                     = { for inst in local.rules_0001 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_range            = each.value.SourcePortRange
  destination_port_range       = each.value.DestinationPortRange
  source_address_prefix        = each.value.SourceAddressPrefix
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0010" {
  for_each                    = { for inst in local.rules_0010 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_range           = each.value.SourcePortRange
  destination_port_range      = each.value.DestinationPortRange
  source_address_prefixes     = split(",", each.value.SourceAddressPrefix)
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0011" {
  for_each                     = { for inst in local.rules_0011 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_range            = each.value.SourcePortRange
  destination_port_range       = each.value.DestinationPortRange
  source_address_prefixes      = split(",", each.value.SourceAddressPrefix)
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0100" {
  for_each                    = { for inst in local.rules_0100 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_range           = each.value.SourcePortRange
  destination_port_ranges     = split(",", each.value.DestinationPortRange)
  source_address_prefix       = each.value.SourceAddressPrefix
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0101" {
  for_each                     = { for inst in local.rules_0101 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_range            = each.value.SourcePortRange
  destination_port_ranges      = split(",", each.value.DestinationPortRange)
  source_address_prefix        = each.value.SourceAddressPrefix
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0110" {
  for_each                    = { for inst in local.rules_0110 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_range           = each.value.SourcePortRange
  destination_port_ranges     = split(",", each.value.DestinationPortRange)
  source_address_prefixes     = split(",", each.value.SourceAddressPrefix)
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_0111" {
  for_each                     = { for inst in local.rules_0111 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_range            = each.value.SourcePortRange
  destination_port_ranges      = split(",", each.value.DestinationPortRange)
  source_address_prefixes      = split(",", each.value.SourceAddressPrefix)
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1000" {
  for_each                    = { for inst in local.rules_1000 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_ranges          = split(",", each.value.SourcePortRange)
  destination_port_range      = each.value.DestinationPortRange
  source_address_prefix       = each.value.SourceAddressPrefix
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1001" {
  for_each                     = { for inst in local.rules_1001 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_ranges           = split(",", each.value.SourcePortRange)
  destination_port_range       = each.value.DestinationPortRange
  source_address_prefix        = each.value.SourceAddressPrefix
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1010" {
  for_each                    = { for inst in local.rules_1010 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_ranges          = split(",", each.value.SourcePortRange)
  destination_port_range      = each.value.DestinationPortRange
  source_address_prefixes     = split(",", each.value.SourceAddressPrefix)
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1011" {
  for_each                     = { for inst in local.rules_1011 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_ranges           = split(",", each.value.SourcePortRange)
  destination_port_range       = each.value.DestinationPortRange
  source_address_prefixes      = split(",", each.value.SourceAddressPrefix)
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1100" {
  for_each                    = { for inst in local.rules_1100 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_ranges          = split(",", each.value.SourcePortRange)
  destination_port_ranges     = split(",", each.value.DestinationPortRange)
  source_address_prefix       = each.value.SourceAddressPrefix
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1101" {
  for_each                     = { for inst in local.rules_1101 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_ranges           = split(",", each.value.SourcePortRange)
  destination_port_ranges      = split(",", each.value.DestinationPortRange)
  source_address_prefix        = each.value.SourceAddressPrefix
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1110" {
  for_each                    = { for inst in local.rules_1110 : inst.Name => inst }
  name                        = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                    = each.value.Priority
  direction                   = each.value.Direction
  access                      = each.value.Access
  protocol                    = each.value.Protocol
  source_port_ranges          = split(",", each.value.SourcePortRange)
  destination_port_ranges     = split(",", each.value.DestinationPortRange)
  source_address_prefixes     = split(",", each.value.SourceAddressPrefix)
  destination_address_prefix  = each.value.DestinationAddressPrefix
  description                 = each.value.Description
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}
resource "azurerm_network_security_rule" "rules_1111" {
  for_each                     = { for inst in local.rules_1111 : inst.Name => inst }
  name                         = format("%s_%s_%s_%s", each.value.Access, each.value.Priority, each.value.Direction, each.value.DestinationPortRange)
  priority                     = each.value.Priority
  direction                    = each.value.Direction
  access                       = each.value.Access
  protocol                     = each.value.Protocol
  source_port_ranges           = split(",", each.value.SourcePortRange)
  destination_port_ranges      = split(",", each.value.DestinationPortRange)
  source_address_prefixes      = split(",", each.value.SourceAddressPrefix)
  destination_address_prefixes = split(",", each.value.DestinationAddressPrefix)
  description                  = each.value.Description
  resource_group_name          = azurerm_resource_group.tf-rg.name
  network_security_group_name  = azurerm_network_security_group.tf-nsg.name
}
