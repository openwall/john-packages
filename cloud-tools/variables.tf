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

# TODO ###############################################################
# Change the cidr_blocks below to update using your IP address.
variable ingress_data {
  description = "The secutiry groups inbound rules."
  type = map(object({description = string, cidr_blocks = list(string)}))
  default = {
    22 = { description = "Inbound SSH rule", cidr_blocks = [ "45.170.58.160/32" ] }
  }
}

variable egress_data {
  description = "The secutiry groups outbound rules."
  type = map(object({description = string, cidr_blocks = list(string), ipv6_cidr_blocks = list(string)}))
  default = {
    80 = { description = "Outbound HTTP rule", cidr_blocks = [ "0.0.0.0/0" ], ipv6_cidr_blocks = ["::/0"] }
    443 = { description = "Outbound HTTPS rule", cidr_blocks = [ "0.0.0.0/0" ], ipv6_cidr_blocks = ["::/0"] }
  }
}
# ####################################################################

# Create terraform workspaces (to choose accounts/regions to use). ###
# For example, to use a different IAM account or region, use the 'testing' workspace.
# $ terraform workspace new    testing
# $ terraform workspace select testing
# $ terraform workspace list

# TODO ###############################################################
# Set your AWS profile file AND/OR  regions AND/OR the label.
variable "profile_list" {
  description = "Your section inside the `~/.aws/credentials` profile file."
  type = map(string)
  default = {
    default = "cracker"
    testing = "cracker-testing"
    production = "cracker-production"
  }
}

variable "regions_list" {
  description = "AWS region to launch servers."
  type = map(string)
  default = {
    default = "us-east-1"
    testing = "us-east-1"
    production = "us-west-1"
  }
}

variable "environment_list" {
  description = "A label users might like to see."
  type = map(string)
  default = {
    default = "default"
    testing = "DEV"
    production = "PROD"
  }
}
# ####################################################################

# TODO ###############################################################
# Change SSH information, use your own keys or create a new one.
# Or run `$ ssh-keygen -t rsa -f jtr-workerKey`
variable "private_key" {
  default = "./jtr-workerKey"
  sensitive = true
}

variable "public_key" {
  default = "./jtr-workerKey.pub"
}

locals {
  public_key_content = "${file("${var.public_key}")}"
}

locals {
  private_key_content = "${file("${var.private_key}")}"
  sensitive = true
}
# ####################################################################

# TODO ###############################################################
# Pick up your EC2 instances environment.
variable instance {
  type = object({instance_type = string, count = number})
  default = {
    instance_type = "t2.micro", count = 1
  }
}
# ####################################################################

variable domain {
  type = string
  default = "John the Ripper cracking agent (worker)"
}

variable role {
  type = string
  default = "Cracking Session"
}
variable owner {
  type = string
  default = "User name"
}

variable customer {
  type = string
  default = "Custormer or Project Name"
}

variable confidentiality {
  type = string
  default = "Default"
}