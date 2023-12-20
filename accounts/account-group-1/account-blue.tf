provider "newrelic" {
  alias = "acc_blue"
  region = var.provider_config.accounts.acc_blue.region
  api_key =  var.provider_config.accounts.acc_blue.api_key
  account_id = var.provider_config.accounts.acc_blue.account_id
}

module "alerts_blue" {
    source = "../../common/modules/ExampleAlerts"
    providers = {
        newrelic = newrelic.acc_blue
    }
    alias = "acc_blue"
}

module "synthetics_blue" {
    for_each = var.config.accounts.acc_blue.synthetics

    source = "../../common/modules/ExampleSynthetic"
    providers = {
        newrelic = newrelic.acc_blue
    }

    alias = "acc_blue"
    name = each.key
    url = each.value.url
    locations = each.value.locations 
}