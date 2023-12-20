config = {
    accounts = {
        acc_blue = {
            synthetics = {
                "NewRelic" =  {
                    url = "https://one.newrelic.com"
                    locations = ["AWS_EU_WEST_2"]
                }
                "BBC" =  {
                    url = "https://bbc.com"
                    locations = ["AWS_EU_WEST_2"]
                }
            }
        },
        acc_red = {
            synthetics = {
                "CNN" =  {
                    url = "https://cnn.com"
                    locations = ["AWS_EU_WEST_2"]
                }
                "Google" =  {
                    url = "https://www.google.com"
                    locations = ["AWS_EU_WEST_2"]
                }
            }
        }

    }
}