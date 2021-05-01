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

resource "aws_security_group" "jtrcrackers-sg" {
  name        = "JtRCracker-sg"
  description = "Allow SSH access to the end user"

  dynamic "ingress" {
    for_each = var.ingress_data
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "outgress" {
    for_each = var.outgress_data
    content {
      description = outgress.value["description"]
      from_port   = outgress.key
      to_port     = outgress.key
      protocol    = "tcp"
      cidr_blocks = outgress.value["cidr_blocks"]
    }
  }

  tags = {
    Name = "JtRCrackerSecurityGroup-sg"
    Environment = var.domain
    "Application Role" = var.role
    Owner = var.owner
    Customer = var.customer
    Confidentiality = var.confidentiality
  }
}