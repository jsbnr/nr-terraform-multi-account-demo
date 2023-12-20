# Multi New Relic Account Terraform Example

This example code shows one of the many ways you may wish to arrange your Terraform project to manage resources for multiple accounts in New Relic.

## Background

### State management
One of the issues this project addresses is to split the  management of different accounts into seperate terraform state files. Its good practice to keep the terraform state small. For implemntations where there is a lot of similar or boilerplate resources deployed across many accounts its tempting to deploy them all together but this can lead to slow and unreliable changes and also is at risk of small changes having a large blast radius.

The solution proposed in this project is to group accounts together into logical groups. All the accounts resources for each group are managed in the same state file. You can have one or many accounts in each group, remembering that they will be managed as one set of terraform resources. The folder structure looks like this:

```
-accounts
----account-group-1
--------(state and resources config for these accounts)
----account-group-2
--------(state and resources config for these accounts)
----account-group-n
--------(state and resources config for these accounts)
-common
----modules
--------ExampleAlert
--------ExampleSynthetic
```

**IMPORTANT:** It is essential that the [state file](https://developer.hashicorp.com/terraform/language/state) is managed properly and stored in a [backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration#available-backends) that supports version control. There are many options such as Azure and AWS S3 blob storage and the like. *This is not addressed in this sample code, state is stored locally.*


### Modules
This project also includes some examples on how to create custom common [modules](https://developer.hashicorp.com/terraform/language/modules) that can be shared between all the accounts. This approach allows you to build common resource sets that can be used by all the accounts. Included is just basic implmentation, but its possible to use [published modules](https://developer.hashicorp.com/terraform/language/modules#published-modules) that leverage versioning and can help with the lifecycle and long term maintenance of the code base.

In this example project we place the modules in a common folder that is accessible to all the account groups. You could of course build custom modules for specific account groups too and locate them withon the account group folders.


### Configuration driven
Whilst its possible to configure all the resources for an account in terrafrom using HCL this can be rather unweidly and requires certain skills. This project includes a simple example of how to drive a module (ExampleSynthetic) via a simple configuration object (config.tfvars). This allows people with the necessary HCL skills to build the terraform modules and allows others to configure them easily with little HCL knowdledge required.


## About the demo
The demo models an organisation with three accounts (simply named "red", "green" and "blue"). The blue and red accounts are managed together in `account-group-1` and the green account is managed seperately in `account-group-2`. For each account we have chosen to have a single `.tf` (e.g. `account-red.tf`) file that drives the account resources by calling modules.

The demo simply creates an alert policy for each account and sets up multiple synthetic ping monitors. The ping monitors are configured for each account using configuration data in config.tfvars.

For each account a New Relic provider is created, with the necessary credentials applied from configuration passed in at runtime via the command line. This provider is then passed to the modules to ensure the resources are created in the correct account. There is no need to set up environment variables with your New Relic account details!


### Demo setup
You will need terraform installed to run the demo. You will also need at least one New Relic account. The demo works best with three seperate accounts but you can get away with using a single account by making the credentials the same for each of red, blue and green accounts juist to get a feel for things.

#### 1. Configure the credentials
First we need to configure the sensitve credentials for the project. You'll need to generate a New Relic User API key for each account. 

Navigate to the `/accounts/account-group-1`` folder and copy the `newrelic_creds.tfvars.sample`` to a new file called `newrelic_creds.tfvars.secrets`. Update the file with your API key, account ID and if necessary adjust the region.(This .secrets file is excluded from the git repo via .gitignore)

#### 2. Configure synhtetics
In this demo we allow the user to specify a number of ping monitors via the configuration file `config.tfvars`. This is already set up, so nothing to do here, but feel free to add or amend the ping monitors in this file. You could extend the object here to drive all sorts of resources from simple configuration.

#### 3. Initialise and plan/apply
Within the `/accounts/account-group-1` folder run the following commands to initialise the terraform modules and plan/apply:

```
terraform init
terraform plan -var-file="newrelic_creds.tfvars.secret" -var-file="config.tfvars
```

You can apply changes with:
```
terraform apply -var-file="newrelic_creds.tfvars.secret" -var-file="config.tfvars
```

You can see in the above commands that we provide both the secrets containing the API key's and the config as input variables.

#### 4. Repeat with account-group-2
Repeate the above steps within the folder `account-group-2`. You should notice that the resources are managed seperately using different state files for each group.
