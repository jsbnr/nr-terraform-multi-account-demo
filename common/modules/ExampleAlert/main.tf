# Just creates an alerts policy in account

# Note we pass in an 'alias', which is a short account name label, that is used as part of the name of the policy
# We do this to make it easier to see in the UI which resources are managed by which configuration.check "name".
# If the resources are in different accounts then this may not be necessary for your own setup. 

resource "newrelic_alert_policy" "policy" {
  name = "${var.alias} - Example terraform managed alert policy"
  incident_preference = "PER_POLICY" 
}
