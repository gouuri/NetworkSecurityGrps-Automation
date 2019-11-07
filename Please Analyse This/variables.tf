variable "functions" {
  # type = list(string)
  type = "list"
  description = "List of functions to create Security Groups for"
}

# variable "inbound_rules" {
#   type = "list"
#   description = "List of inbound rules"

#   default = [
#     {
#       name = "AllowAnyInbound"
#       priority = 100
#       direction = "Inbound"
#       access = "Allow"
#       protocol = "*"
#       source_port_range = "*"
#       destination_port_range = "*"
#       source_address_prefix = "*"
#       destination_address_prefix = "*"
#     }
#   ]
# }

# variable "outbound_rules" {
#   type = "list"
#   description = "List of outbound rules"

#   default = [
#     {
#       name = "AllowAnyOutbound"
#       priority = 100
#       direction = "Outbound"
#       access = "Allow"
#       protocol = "*"
#       source_port_range = "*"
#       destination_port_range = "*"
#       source_address_prefix = "*"
#       destination_address_prefix = "*"
#     }
#   ]
# }
