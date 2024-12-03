terraform {
  required_version = ">= 1.7.2"

  required_providers {
    dokku = {
      source  = "registry.terraform.io/aliksend/dokku"
      version = "~> 1.0.22"
    }

    shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}
