resource "newrelic_alert_policy" "policy" {
  name = "${var.alias} - Example terraform managed alert policy"
  incident_preference = "PER_POLICY" 
}
