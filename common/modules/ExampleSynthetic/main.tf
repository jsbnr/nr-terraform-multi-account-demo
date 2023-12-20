resource "newrelic_synthetics_monitor" "monitor" {
  status           = "DISABLED" #disabled as this is only a demo
  name             = "Simple monitor: ${var.alias} - ${var.name}"
  period           = "EVERY_HOUR"
  uri              = var.url
  type             = "SIMPLE"
  locations_public = var.locations

  treat_redirect_as_failure = false
  bypass_head_request       = true
  verify_ssl                = true
}