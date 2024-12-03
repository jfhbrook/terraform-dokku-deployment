variable "ssh_host" {
  description = "SSH host"
  type        = string
  default     = null
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = null
}

variable "hostname" {
  description = "The hostname for the Dokku instance"
  type        = string
  default     = null
}

variable "port" {
  description = "Port to expose from the application"
  type        = number
  default     = null
}

variable "letsencrypt" {
  description = "Letsencrypt configuration"
  // TODO: validate keys and values
  type = map(any)
  default = {
    enable = false
  }
}
