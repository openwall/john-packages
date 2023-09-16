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
# Copyright (c) 2021 Claudio André <claudioandre.br at gmail.com>
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

terraform {
  required_providers {
    local = "~> 2.0"
    aws   = "~> 5.0"
  }
}

provider "aws" {
  region  = local.region
  profile = local.profile
}

# Create workspaces to run the same set of instruction on different environments
locals {
  profile = lookup(var.profile_list, terraform.workspace)
}
locals {
  region = lookup(var.regions_list, terraform.workspace)
}
locals {
  run_env = lookup(var.environment_list, terraform.workspace)
}

# Save terraform state remotely (if needed).
/* terraform {
  backend "s3" {
    bucket = "jtrcrackers-tfstate"
    key    = "sg/terraform.state"
    region = var.region
    profile = var.profile
  }
} */
