######################################################################
# Copyright (c) 2021 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

output current_environment {
  value = local.run_env
}

output "ip_address" {
  value = "${aws_instance.worker.*.public_ip}"
  description = "The IP address(es) of the instance(s)."
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      public-dns = aws_instance.worker.*.public_dns,
      public-ip = aws_instance.worker.*.public_ip,
      public-id = aws_instance.worker.*.id
    }
  )
  filename = "inventory"
}
