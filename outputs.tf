output "latest_snapshot_id" {
  description = "The ID of the most recent RDS snapshot."
  value       = local.snapshot_id
}

output "latest_snapshot_arn" {
  description = "The ARN of the most recent RDS snapshot."
  value       = local.snapshot_arn
}

output "new_instance_address" {
  description = "The connection address for the new RDS instance."
  value       = try(aws_db_instance.new_instance[0].address, null)
}