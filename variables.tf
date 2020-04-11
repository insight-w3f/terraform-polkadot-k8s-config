
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
  type = bool
  default = true
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
