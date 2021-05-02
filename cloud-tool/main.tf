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

provider "aws" {
  region = local.region
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