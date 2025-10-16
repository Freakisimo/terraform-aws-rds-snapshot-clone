resource "aws_db_subnet_group" "new_subnet_group" {
  count = var.vpc_name != null ? 1 : 0

  name       = "${var.new_db_instance_identifier}-sng"
  subnet_ids = data.aws_subnets.selected[0].ids
}

resource "aws_db_instance" "new_instance" {
  count = var.create_new_instance ? 1 : 0

  identifier              = var.new_db_instance_identifier
  snapshot_identifier     = local.snapshot_arn
  instance_class          = var.instance_class
  username                = local.master_username
  password                = local.master_password
  db_subnet_group_name    = var.vpc_name != null ? aws_db_subnet_group.new_subnet_group[0].name : var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = var.skip_final_snapshot

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  lifecycle {
    precondition {
      condition     = var.db_subnet_group_name != null || var.vpc_name != null
      error_message = "When creating a new instance, either db_subnet_group_name or vpc_name must be specified."
    }
    precondition {
      condition     = !(var.db_subnet_group_name != null && var.vpc_name != null)
      error_message = "When creating a new instance, only one of db_subnet_group_name or vpc_name can be specified."
    }
  }
}
