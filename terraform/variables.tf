# APPLICATION #
variable "ENVIRONMENT" {
  type        = string
  description = "Enviroment of infrastructure"
}

# AWS #
variable "AVAILABILITY_ZONES" {
  type        = list(string)
  description = "AWS availability zones"
}

variable "REGION" {
  type        = string
  description = "Region where aws will create resources"
}

variable "PROFILE" {
  type        = string
  description = "Profile of aws"
}

variable "ACCESS_KEY" {
  type        = string
  description = "AWS access key"
}

variable "SECRET_KEY" {
  type        = string
  description = "AWS secret key"
}

# NETWORKS #
variable "VPC_CIDR_BLOCK" {
  type        = string
  description = "VPC cidr block"
}

variable "PUBLIC_SUBNETS_CIDR" {
  type        = list(string)
  description = "Public subnet cidr values"
}

variable "PRIVATE_SUBNETS_CIDR" {
  type        = list(string)
  description = "Private subnet cidr values"
}

# RDS #
variable "RDS_NAME" {
  type        = string
  description = "RDS database name"
}

variable "RDS_USERNAME" {
  type        = string
  description = "RDS database username"
}

variable "RDS_PASSWORD" {
  type        = string
  description = "RDS database password"
}