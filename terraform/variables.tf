variable "project" {
  type        = string
  description = "Name of the project to be used as a prefix for all resources."
  default     = "pp"
}
variable "aws_region" {
  type        = string
  description = "AWS region to target."
  default     = "eu-central-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
