
######
# svcs
######
variable "all_enabled" {
  description = "Bool to enable all services"
  type        = bool
  default     = true
}

variable "consul_enabled" {
  description = "Bool to enable consul"
  type        = bool
  default     = true
}

variable "elasticsearch_enabled" {
  description = "Bool to enable elasticsearch"
  type        = bool
  default     = true
}

variable "prometheus_enabled" {
  description = "Bool to enable prometheus"
  type        = bool
  default     = true
}

variable "nginx_ingress_enabled" {
  description = "Bool to enable nginx ingress"
  type        = bool
  default     = true
}

variable "external_dns_enabled" {
  description = "Bool to enable external DNS controller"
  type        = bool
  default     = true
}

variable "region" {
  description = "The region where the cluster is deployed"
  type        = string
}

variable "cloud_platform" {
  description = "The cloud platform where the cluster is deployed"
  type        = string
}

variable "slack_api_key" {
  description = "Your Slack API key to receive alerts"
  type        = string
  default     = ""
}

variable "alertmanager_subdomain" {
  description = "The subdomain for AlertManager"
  type        = string
  default     = "alertmanager"
}

variable "grafana_subdomain" {
  description = "The subdomain for Grafana"
  type        = string
  default     = "grafana"
}

variable "prometheus_subdomain" {
  description = "The subdomain for Prometheus"
  type        = string
  default     = "prometheus"
}

variable "root_domain_name" {
  description = "The root domain name"
  type        = string
}

variable "azure_service_principal_key" {
  description = "Contents of the JSON file for the Azure service principal"
  type        = string
  default     = ""
}

variable "azure_resource_group" {
  description = "The Azure resource group"
  type        = string
  default     = ""
}

variable "google_project" {
  description = "Name of GCP project"
  type        = string
  default     = ""
}

variable "google_service_account_key" {
  description = "Contents of the JSON file for the GCP service account"
  type        = string
  default     = ""
}

variable "do_token" {
  description = "The DO API token"
  type        = string
  default     = ""
}

variable "lb_endpoint" {
  description = "URI/IP to the load balancer endpoint"
  type        = string
  default     = ""
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "aws_worker_arn" {
  description = "ARN for EKS worker nodes"
  type        = string
  default     = ""
}

variable "wait_on" {
  description = "Variable to trick TF into waiting for everything else to finish"
  type        = string
  default     = ""
}