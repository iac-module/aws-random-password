# Password variables
variable "length" {
  description = "(Number) The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)"
  type        = number
  default     = 16
}

variable "keepers" {
  description = "(Map of String) Arbitrary map of values that, when changed, will trigger recreation of resource"
  type        = map(string)
  default     = {}
}

variable "lower" {
  description = "(Boolean) Include lowercase alphabet characters in the result"
  type        = bool
  default     = true
}

variable "min_lower" {
  description = "Minimum number of lowercase alphabet characters in the result."
  type        = number
  default     = 0
}

variable "min_numeric" {
  description = "Minimum number of numeric characters in the result"
  type        = number
  default     = 0
}
variable "min_special" {
  description = "Minimum number of special characters in the result"
  type        = number
  default     = 0
}

variable "min_upper" {
  description = "Minimum number of uppercase alphabet characters in the result"
  type        = number
  default     = 0
}

variable "numeric" {
  description = "(Boolean) Include numeric characters in the result. Default value is true. If numeric, upper, lower, and special are all configured, at least one of them must be set to true"
  type        = bool
  default     = true
}

variable "override_special" {
  description = "(String) Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument. The special argument must still be set to true for any overwritten characters to be used in generation"
  type        = string
  default     = ""
}

variable "special" {
  description = "(Boolean) Include special characters in the result. These are !@#$%&*()-_=+[]{}<>:?"
  type        = bool
  default     = true
}

variable "upper" {
  description = "(Boolean) Include uppercase alphabet characters in the result"
  type        = bool
  default     = true
}

# ParamStore variables
variable "ssm_parameter" {
  description = "ParamStore variables"
  type = object({
    enabled     = optional(bool, false)
    tags        = optional(map(string), {})
    name        = optional(string, null)
    description = optional(string, "The generated password")
    type        = optional(string, "SecureString")
    key_id      = optional(string, "")
  })
  default = {
  }
}

# SecretManager variables
variable "secrets_manager" {
  description = "ParamStore variables"
  type = object({
    create                           = optional(bool, true)
    tags                             = optional(map(string), {})
    description                      = optional(string, null)
    force_overwrite_replica_secret   = optional(bool, null)
    kms_key_id                       = optional(string, null)
    name                             = optional(string, null)
    name_prefix                      = optional(string, null)
    recovery_window_in_days          = optional(number, null)
    replica                          = optional(map(any), {})
    create_policy                    = optional(bool, false)
    source_policy_documents          = optional(list(string), [])
    override_policy_documents        = optional(list(string), [])
    policy_statements                = optional(map(any), {})
    block_public_policy              = optional(bool, null)
    ignore_secret_changes            = optional(bool, false)
    secret_string                    = optional(string, null)
    secret_binary                    = optional(string, null)
    version_stages                   = optional(list(string), null)
    create_random_password           = optional(bool, false)
    random_password_length           = optional(number, 32)
    random_password_override_special = optional(string, "!@#$%&*()-_=+[]{}<>:?")
    enable_rotation                  = optional(bool, false)
    rotation_lambda_arn              = optional(string, "")
    rotation_rules                   = optional(map(any), {})
  })
  default = {
  }
}
