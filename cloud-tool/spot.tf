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

resource "aws_spot_instance_request" "worker" {
  ami           = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.jtrcrackers-sg.id]
  key_name = aws_key_pair.deployer.key_name
  instance_type = var.instance["instance_type"]
  count = "${var.spot == "yes" ? var.instance["count"] : 0}"


  spot_price = "${var.spot_price}"
  wait_for_fulfillment = true
  spot_type = "one-time"

  credit_specification {
    cpu_credits = "standard"
  }

  # The connection uses the local SSH agent for authentication.
  connection {
    user        = "ubuntu"
    type        = "ssh"
    host        = self.public_ip
    private_key = local.private_key_content
  }

  provisioner "file" {
    source      = "./build-john.sh"
    destination = "/home/ubuntu/"
  }

  provisioner "file" {
    source      = "./hashes.txt"
    destination = "/home/ubuntu/hashes.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~",
      "ls -laR"
    ]
  }

  depends_on = [
    # Security group rule must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aws_security_group.jtrcrackers-sg,
  ]

  tags = {
    Name = "JtRCracker${count.index + 1}-instance"
    Environment = var.domain
    "Application Role" = var.role
    Owner = var.owner
    Customer = var.customer
    Confidentiality = var.confidentiality
  }
}