locals {
  dockerfile    = fileexists("Dockerfile") ? file("Dockerfile") : null
  port_re       = "(?m)^\\s*EXPOSE\\s+(?P<exposed_port>\\d+)\\s*$"
  port          = coalesce(var.port, tonumber(regex(local.port_re, local.dockerfile).exposed_port))
  app_json      = fileexists("app.json") ? jsondecode(file("app.json")) : null
  app_name      = coalesce(var.app_name, local.app_json.name)
  domain        = "${local.app_name}.${var.hostname}"
  http_protocol = var.letsencrypt.enable ? "http" : "https"
  app_url       = "${local.http_protocol}://${local.domain}"
  ssh_host      = coalesce(var.ssh_host, var.hostname)
}

module "remote" {
  source = "git::ssh://github.com/jfhbrook/terraform-shell-git-remote?ref=1.0"

  path = path.cwd
  name = "dokku"
  url  = "dokku@${var.ssh_host}:${local.app_name}"
}

resource "dokku_app" "this" {
  app_name = local.app_name

  // TODO: It would be nice to have more dynamicism here, but the provider
  // does not handle unknown or mismatched types gracefully.
  domains = [
    local.domain
  ]

  ports = {
    80 = {
      scheme         = "http"
      container_port = local.port
    }
  }
}

module "head" {
  source = "git::ssh://github.com/jfhbrook/terraform-shell-git-ref?ref=1.0"

  path    = path.cwd
  refspec = "HEAD"
}

module "deploy" {
  source = "git::ssh://github.com/jfhbrook/terraform-shell-git-push?ref=1.0"

  path   = path.cwd
  remote = module.remote.name
  branch = module.head.branch
}

resource "dokku_letsencrypt" "this" {
  count = var.letsencrypt.enable ? 1 : 0

  app_name = local.app_name
  email    = var.letsencrypt.email

  depends_on = [
    dokku_app.this,
    module.deploy
  ]
}
