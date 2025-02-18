include {
  path = find_in_parent_folders("root.hcl")
}
iam_role = local.account_vars.iam_role

terraform {
  source = "git::https://github.com/iac-module/aws-random-password.git?ref=v0.0.1"
}

locals {
  common_tags  = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region       = local.region_vars.locals.aws_region
  name         = basename(get_terragrunt_dir())
}

inputs = {
  length = 20
  secrets_manager = {
    name = "${local.account_vars.locals.env_name}/elasticache/svc/${local.name}"
  }
}
