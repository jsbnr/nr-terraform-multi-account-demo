
provider "newrelic" {
  alias = "acc_red"
  region = var.provider_config.accounts.acc_red.region
  api_key =  var.provider_config.accounts.acc_red.api_key
  account_id = var.provider_config.accounts.acc_red.account_id
}

module "alerts_red" {
    source = "../../common/modules/ExampleAlerts"
    providers = {
        newrelic = newrelic.acc_red
    }
    alias = "acc_red"
}

module "synthetics_red" {
    for_each = var.config.accounts.acc_red.synthetics

    source = "../../common/modules/ExampleSynthetic"
    providers = {
        newrelic = newrelic.acc_red
    }

    alias = "acc_red"
    name = each.key
    url = each.value.url
    locations = each.value.locations 
}