output "bcrypt_hash" {
  description = "(String, Sensitive) A bcrypt hash of the generated random string. NOTE: If the generated random string is greater than 72 bytes in length, bcrypt_hash will contain a hash of the first 72 bytes."
  sensitive   = true
  value       = try(random_password.password.bcrypt_hash, "")
}
output "id" {
  description = "(String) A static value used internally by Terraform, this should not be referenced in configurations."
  value       = try(random_password.password.id, "")
}
output "result" {
  description = "(String, Sensitive) The generated random string."
  sensitive   = true
  value       = try(random_password.password.result, "")
}
