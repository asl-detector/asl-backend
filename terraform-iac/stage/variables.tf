variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
  default     = "asl-dataset-stage"
}

variable "uuid" {
  description = "A unique identifier that will be appended to various names."
  type        = string
  default     = "asl-dataset-stage-00"
}

variable "environment" {
  description = "API Gateway stage/environment (dev, stage, prod …)"
  type        = string
  default     = "STG"
}