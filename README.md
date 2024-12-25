# terraform-dokku-deployment

An opinionated module for deploying to [Dokku](https://dokku.com), using the
[Dokku provider](https://registry.terraform.io/providers/aliksend/dokku/latest/docs).

## Usage

The basic usage looks like this:

```tf
// This module uses these two providers
terraform {
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

provider "dokku" {
  ssh_host = var.ssh_host
  ssh_cert = var.ssh_cert
}

module "app" {
  source = "jfhbrook/deployment"
  version = "1.0.3"

  hostname = var.hostname
  ssh_host = var.ssh_host

  letsencrypt = {
    enable = var.letsencrypt_enable
    email = var.letsencrypt_email
  }
}
```

Running `terraform apply` will create the app on your Dokku instance, configure the git remote, do a git push, and enable letsencrypt.

For more information, see:

- [The Dokku provider](https://registry.terraform.io/providers/aliksend/dokku/latest/docs)
- The modules on GitHub I use to wrap git:
  - [terraform-shell-git-ref](https://github.com/jfhbrook/terraform-shell-git-ref)
  - [terraform-shell-git-remote](https://github.com/jfhbrook/terraform-shell-git-remote)
  - [terraform-shell-git-push](https://github.com/jfhbrook/terraform-shell-git-push)

## License

I've licensed this MIT.
