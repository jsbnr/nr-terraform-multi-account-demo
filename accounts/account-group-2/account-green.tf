provider "newrelic" {
  alias = "acc_green"
  region = var.provider_config.accounts.acc_green.region
  api_key =  var.provider_config.accounts.acc_green.api_key
  account_id = var.provider_config.accounts.acc_green.account_id
}

module "alerts_green" {
    source = "../../common/modules/ExampleAlerts"
    providers = {
        newrelic = newrelic.acc_green
    }
    alias = "acc_green"
}

module "synthetics_green" {
    for_each = var.config.accounts.acc_green.synthetics
    
    source = "../../common/modules/ExampleSynthetic"
    providers = {
        newrelic = newrelic.acc_green
    }

    alias = "acc_green"
    name = each.key
    url = each.value.url
    locations = each.value.locations 
}