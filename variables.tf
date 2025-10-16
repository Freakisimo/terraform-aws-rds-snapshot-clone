variable "db_instance_identifier" {
  description = "The ID of the DB instance for which to retrieve the most recent snapshot. Required if manual_snapshot_identifier is not provided."
  type        = string
  default     = null
}

variable "manual_snapshot_identifier" {
  description = "Optional: The ARN or ID of a specific RDS snapshot to use. If provided, the module will use this snapshot instead of finding the most recent one."
  type        = string
  default     = null
}

variable "create_new_instance" {
  description = "Whether to create a new RDS instance from the snapshot."
  type        = bool
  default     = false
}

variable "new_db_instance_identifier" {
  description = "The identifier for the new RDS instance. Required if create_new_instance is true."
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance class to use for the new RDS instance. Required if create_new_instance is true."
  type        = string
  default     = null
}

variable "master_username" {
  description = "The username for the master database user. Required if master_credentials_secret_arn is not provided."
  type        = string
  default     = null
}

variable "master_password" {
  description = "The password for the master database user. Required if master_credentials_secret_arn is not provided."
  type        = string
  default     = null
  sensitive   = true
}

variable "master_credentials_secret_arn" {
  description = "The ARN of the secret containing the master username and password. If provided, this will override the master_username and master_password variables."
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "The DB subnet group name for the new RDS instance. If not provided, a new one will be created based on the vpc_name."
  type        = string
  default     = null
}

variable "vpc_name" {
  description = "The name of the VPC to create the DB subnet group in. Used if db_subnet_group_name is not provided."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs for the new RDS instance."
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled for the DB instance."
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (default) or 731 (2 years)."
  type        = number
  default     = 7
}
