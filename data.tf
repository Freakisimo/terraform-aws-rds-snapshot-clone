data "aws_db_snapshot" "latest_snapshot" {
  count = var.manual_snapshot_identifier == null ? 1 : 0

  db_instance_identifier = var.db_instance_identifier
  most_recent            = true
}

data "aws_db_snapshot" "manual_snapshot" {
  count = var.manual_snapshot_identifier != null ? 1 : 0

  db_snapshot_identifier = var.manual_snapshot_identifier
}

data "aws_secretsmanager_secret_version" "master_credentials" {
  count = var.master_credentials_secret_arn != null ? 1 : 0

  secret_id = var.master_credentials_secret_arn
}

data "aws_vpc" "selected" {
  count = var.vpc_name != null ? 1 : 0

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "selected" {
  count = var.vpc_name != null ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected[0].id]
  }
}