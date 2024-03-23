
variable "region" {
  type        = string
  description = "GCP region"
}

variable "project" {
  type        = string
  description = "GCP project Id"
}

variable "dataset_id" {
  type        = string
  description = "Dataset Name"
}

variable "logsink_name" {
  type        = string
  description = "Name of the logsink"
}

