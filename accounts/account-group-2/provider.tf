terraform {
  required_version = "~> 1.6.4"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

# Example basic S3 remote state
# Uncomment and set to your own configuration.
# More details: https://www.terraform.io/docs/backends/types/s3.html

# terraform {
#   backend "s3" {
#     bucket = "your-s3-bucket-name"
#     key    = "some-folder/terrafrom.tfstate"
#     region = "your-aws-region" 
#     profile = "your-aws-profile-name"
#   }
# }