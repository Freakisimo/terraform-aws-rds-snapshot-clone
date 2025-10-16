# Terraform AWS RDS Latest Snapshot and Clone Module

This module retrieves the most recent snapshot of an AWS RDS instance and optionally creates a new RDS instance from it.

## Usage

```terraform
module "rds_snapshot_and_clone" {
  source = "Freakisimo/rds-snapshot-clone/aws"

  db_instance_identifier = "your-source-rds-instance-identifier"

  create_new_instance            = true
  new_db_instance_identifier     = "your-new-rds-instance-identifier"
  instance_class                 = "db.t3.medium"
  master_username               = "admin"
  master_password               = "your-secure-password"
  vpc_name                      = "your-vpc-name"
  vpc_security_group_ids        = ["sg-xxxxxxxxxxxxxxxxx"]
  performance_insights_enabled  = true
}

output "snapshot_id" {
  value = module.rds_snapshot_and_clone.latest_snapshot_id
}

output "snapshot_arn" {
  value = module.rds_snapshot_and_clone.latest_snapshot_arn
}

output "new_instance_address" {
  value = module.rds_snapshot_and_clone.new_instance_address
}
```

## Inputs

| Name                                | Description                                                              | Type          | Default                       | Required |
|-------------------------------------|--------------------------------------------------------------------------|---------------|-------------------------------|----------|
| `db_instance_identifier`            | The ID of the DB instance for which to retrieve the most recent snapshot. Required if `manual_snapshot_identifier` is not provided. | `string`      | n/a                           | yes      |
| `manual_snapshot_identifier`        | Optional: The ID or ARN of a specific RDS instance snapshot to use. If provided, the module will validate its existence and use it instead of finding the most recent one. | `string`      | `null`                        | no       |
| `create_new_instance`               | Whether to create a new RDS instance from the snapshot.                  | `bool`        | `false`                       | no       |
| `new_db_instance_identifier`        | The identifier for the new RDS instance.                                 | `string`      | `null`                        | no       |
| `db_subnet_group_name`              | The DB subnet group name for the new RDS instance. If not provided, a new one will be created based on the `vpc_name`. | `string`      | `null`                        | no       |
| `vpc_name`                          | The name of the VPC where the new RDS instance will be created. Used if `db_subnet_group_name` is not provided. | `string`      | `null`                        | no       |
| `instance_class`                    | The instance class for the new RDS instance.                             | `string`      | `null`                        | no       |
| `vpc_security_group_ids`            | A list of VPC security group IDs for the new RDS instance.               | `list(string)`| `[]`                          | no       |
| `skip_final_snapshot`               | Determines whether a final DB snapshot is created before the DB instance is deleted. | `bool`        | `true`                        | no       |
| `performance_insights_enabled`      | Specifies whether Performance Insights are enabled for the DB instance.  | `bool`        | `false`                       | no       |
| `performance_insights_retention_period` | The amount of time in days to retain Performance Insights data. Either 7 (default) or 731 (2 years). | `number`      | `7`                           | no       |

## Outputs

| Name                          | Description                                          |
|-------------------------------|------------------------------------------------------|
| `latest_snapshot_id`          | The ID of the most recent RDS instance snapshot.     |
| `latest_snapshot_arn`         | The ARN of the most recent RDS instance snapshot.    |
| `new_instance_address`        | The connection address for the new RDS instance.     |