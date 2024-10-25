###############################################################################
#        _       _             _   _            _____  _
#       | |     | |           | | | |          |  __ \(_)
#       | | ___ | |__  _ __   | |_| |__   ___  | |__) |_ _ __  _ __   ___ _ __
#   _   | |/ _ \| '_ \| '_ \  | __| '_ \ / _ \ |  _  /| | '_ \| '_ \ / _ \ '__|
#  | |__| | (_) | | | | | | | | |_| | | |  __/ | | \ \| | |_) | |_) |  __/ |
#   \____/ \___/|_| |_|_| |_|  \__|_| |_|\___| |_|  \_\_| .__/| .__/ \___|_|
#                                                       | |   | |
#                                                       |_|   |_|
#
# Copyright (c) 2021-2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Terraform configuration for john the ripper
# More info at https://github.com/openwall/john-packages

output "current_environment" {
  value = local.run_env
}

output "ip_address" {
  value       = aws_instance.worker[*].public_ip
  description = "The IP address(es) of the instance(s)."
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      public-dns = aws_instance.worker[*].public_dns,
      public-ip  = aws_instance.worker[*].public_ip,
      public-id  = aws_instance.worker[*].id
    }
  )
  filename = "inventory"
}
