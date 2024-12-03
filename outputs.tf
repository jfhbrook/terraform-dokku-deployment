output "domain" {
  value = local.domain
}

output "app_name" {
  value = local.app_name
}

output "app_url" {
  value = local.app_url
}

output "dokku_app" {
  value = dokku_app.this
}
