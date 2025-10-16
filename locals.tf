locals {
  latest_snapshot = var.manual_snapshot_identifier == null ? data.aws_db_snapshot.latest_snapshot[0] : null
  manual_snapshot = var.manual_snapshot_identifier != null ? data.aws_db_snapshot.manual_snapshot[0] : null

  snapshot_arn   = coalesce(try(local.manual_snapshot.db_snapshot_arn, null), try(local.latest_snapshot.db_snapshot_arn, null))
  snapshot_id    = coalesce(try(local.manual_snapshot.id, null), try(local.latest_snapshot.id, null))
  engine         = coalesce(try(local.manual_snapshot.engine, null), try(local.latest_snapshot.engine, null))
  engine_version = coalesce(try(local.manual_snapshot.engine_version, null), try(local.latest_snapshot.engine_version, null))

  master_credentials = var.master_credentials_secret_arn != null ? jsondecode(data.aws_secretsmanager_secret_version.master_credentials[0].secret_string) : null

  master_username = var.master_credentials_secret_arn != null ? local.master_credentials.username : var.master_username
  master_password = var.master_credentials_secret_arn != null ? local.master_credentials.password : var.master_password
}
