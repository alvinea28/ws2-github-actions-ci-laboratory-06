# Corrected example. The real module/tests suite supplies its full mock fixtures.
mock_provider "azurerm" {
  source          = "./tests/mocks"
  override_during = plan
}

variables {
  name                = "vnet-ws2-mock"
  resource_group_name = "rg-ws2-mock"
  location            = "westeurope"
  address_space       = ["10.42.0.0/16"]
  subnets = {
    web  = { address_prefixes = ["10.42.1.0/24"] }
    data = { address_prefixes = ["10.42.2.0/24"] }
  }
  tags = { owner = "team", environment = "dev", cost_center = "training", workshop = "ws2" }
}

run "valid_two_subnet_topology" {
  command = plan
  assert {
    condition     = toset(keys(output.subnet_ids)) == toset(["web", "data"])
    error_message = "The valid example must preserve named subnets."
  }
}
