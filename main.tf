data "azurerm_resource_group" "rg1" {
  name     = var.resource_group_names[0]
}

data "azurerm_resource_group" "rg2" {
  name     = var.resource_group_names[1]
}

data "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_names[0]
  resource_group_name = data.azurerm_resource_group.rg1.name
}

data "azurerm_virtual_network" "vnet2" {
  name                = var.vnet_names[1]
  resource_group_name = data.azurerm_resource_group.rg2.name
}

resource "azurerm_virtual_network_peering" "vnet_peer_1" {
  name                         = var.vnet_peering_names[0]
  resource_group_name          = data.azurerm_resource_group.rg1.name
  virtual_network_name         = data.azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  use_remote_gateways          = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "vnet_peer_2" {
  name                         = var.vnet_peering_names[1]
  resource_group_name          = data.azurerm_resource_group.rg2.name
  virtual_network_name         = data.azurerm_virtual_network.vnet2.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  use_remote_gateways          = var.use_remote_gateways
}
