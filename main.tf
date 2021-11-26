##################################################################################
# Registry Module
##################################################################################

resource "tfe_registry_module" "vpc" {
  vcs_repo {
    display_identifier = "${var.vcs_organization_name}/${var.vpc_module_github_path}"
    identifier         = "${var.vcs_organization_name}/${var.vpc_module_github_path}"
    oauth_token_id     = var.tfe_oauth_token_id
  }
}


##################################################################################
# Workspace
##################################################################################

resource "tfe_workspace" "vpc_workspace" {
  name                      = "vpc-workspace"
  organization              = data.tfe_organization.organization.name
  auto_apply                = "false"
  execution_mode            = "remote"
  working_directory         = var.vpc_workspace_repo_directory
  remote_state_consumer_ids = var.remote_state_consumer_ids

  vcs_repo {
    identifier     = "${var.vcs_organization_name}/${var.vcs_workspace_repo_name}"
    oauth_token_id = var.tfe_oauth_token_id
  }
}


##################################################################################
# Slack Notification
##################################################################################

resource "tfe_notification_configuration" "slac_notification" {
  name             = "Slac Notification"
  enabled          = true
  destination_type = "slack"
  triggers         = var.notification_triggers
  url              = var.slack_notification_webhook_url
  workspace_id     = resource.tfe_workspace.vpc_workspace.id
}


##################################################################################
# Workspace Environment Variables
##################################################################################

resource "tfe_variable" "aws_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.aws_acess_key_id
  category     = "env"
  sensitive    = "true"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_secret_acess_key" {
  key          = "AWS_SECRET_ACCESS_KEY "
  value        = var.aws_secret_acess_key
  category     = "env"
  sensitive    = "true"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  description  = "AWS Connection"
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.aws_default_region
  description  = "AWS Default Region"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "env"
}


##################################################################################
# Workspace Variables
##################################################################################

resource "tfe_variable" "vpc_cidr" {
  key          = "vpc_cidr"
  value        = var.vpc_cidr
  description  = "VPC CIDR"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "availability_zones_count" {
  key          = "availability_zones_count"
  value        = var.availability_zones_count
  description  = "AZ Count to create subnets in"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}

resource "tfe_variable" "purpose_tag" {
  key          = "purpose_tag"
  value        = var.purpose_tag
  description  = "Purpose Tag Name"
  workspace_id = resource.tfe_workspace.vpc_workspace.id
  category     = "terraform"
}
