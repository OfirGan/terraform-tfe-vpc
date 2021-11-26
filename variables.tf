##################################################################################
# Terraform Cloud
##################################################################################

variable "tfe_oauth_token_id" {
  description = "Terraform Cloud VCS Token ID"
  type        = string
  sensitive   = true
}

variable "remote_state_consumer_ids" {
  description = "Remote State Consumer ids list"
  type        = list(string)
}


##################################################################################
# VPC Workspace Environment Variables
##################################################################################

variable "aws_acess_key_id" {
  description = "AWS Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_acess_key" {
  description = "AWS Secret Acess Key"
  type        = string
  sensitive   = true
}

variable "aws_default_region" {
  description = "AWS Default Region"
  type        = string
}


##################################################################################
# VPC Workspace Variables
##################################################################################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones_count" {
  description = "AZ Count to create subnets in"
  type        = number
}

variable "purpose_tag" {
  description = "Purpose Tag Name"
  type        = string
}
