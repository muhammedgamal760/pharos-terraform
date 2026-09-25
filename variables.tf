variable "aws_region" {
  type        = string
  description = "AWS region for demo resources"
  default     = "us-west-1"
}

variable "project" {
  type        = string
  description = "Name prefix for demo resources"
  default     = "pharos"
}
