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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Images owned by Canonical (099720109477)
}

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.jtrcrackers-sg.id]
  key_name               = aws_key_pair.deployer.key_name
  instance_type          = var.instance["instance_type"]
  count                  = var.spot != "yes" ? var.instance["count"] : 0
  monitoring             = true

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
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
    Name            = "JtRCracker${count.index + 1}-instance"
    Environment     = var.domain
    appRole         = var.role
    Owner           = var.owner
    Customer        = var.customer
    Confidentiality = var.confidentiality
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = local.public_key_content
}

# You can also add your key here.
/*
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
*/
