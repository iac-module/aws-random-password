resource "random_password" "password" {
  length           = var.length
  keepers          = var.keepers
  lower            = var.lower
  min_lower        = var.min_lower
  min_numeric      = var.min_numeric
  min_special      = var.min_special
  min_upper        = var.min_upper
  numeric          = var.numeric
  override_special = var.override_special
  special          = var.special
  upper            = var.upper
}

resource "aws_ssm_parameter" "secret" {
  count       = var.ssm_parameter.enabled ? 1 : 0
  name        = var.ssm_parameter.name
  description = var.ssm_parameter.description
  type        = var.ssm_parameter.type
  key_id      = var.ssm_parameter.key_id
  value       = random_password.password.result
  tags        = var.ssm_parameter.tags
}

module "secrets_manager" {
  source                           = "git::https://github.com/terraform-aws-modules/terraform-aws-secrets-manager.git?ref=f7749e2d1a58eb548314f3c061b320c67a23b669" # v1.3.1
  create                           = var.secrets_manager.create
  tags                             = var.secrets_manager.tags
  description                      = var.secrets_manager.description
  force_overwrite_replica_secret   = var.secrets_manager.force_overwrite_replica_secret
  kms_key_id                       = var.secrets_manager.kms_key_id
  name                             = var.secrets_manager.name
  name_prefix                      = var.secrets_manager.name_prefix
  recovery_window_in_days          = var.secrets_manager.recovery_window_in_days
  replica                          = var.secrets_manager.replica
  create_policy                    = var.secrets_manager.create_policy
  source_policy_documents          = var.secrets_manager.source_policy_documents
  override_policy_documents        = var.secrets_manager.override_policy_documents
  policy_statements                = var.secrets_manager.policy_statements
  block_public_policy              = var.secrets_manager.block_public_policy
  ignore_secret_changes            = var.secrets_manager.ignore_secret_changes
  secret_string                    = random_password.password.result
  secret_binary                    = var.secrets_manager.secret_binary
  version_stages                   = var.secrets_manager.version_stages
  create_random_password           = var.secrets_manager.create_random_password
  random_password_length           = var.secrets_manager.random_password_length
  random_password_override_special = var.secrets_manager.random_password_override_special
  enable_rotation                  = var.secrets_manager.enable_rotation
  rotation_lambda_arn              = var.secrets_manager.rotation_lambda_arn
  rotation_rules                   = var.secrets_manager.rotation_rules
}
