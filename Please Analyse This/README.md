Terraform module that will create Network Security Groups in Azure.
Requires a few environment variables set:

ARM_SUBSCRIPTION_ID
ARM_CLIENT_ID (optional at this time)
ARM_CLIENT_SECRET
SERVICENAME
FUNCTIONS

The first 3 parameters are required to ensure correct authentication and placement of the NSGs
The 4th parameter will be used as the workspace, and also used to identify for what service the NSGs need to be created (will be included in the name). The reason to use this as the workspace is so that all services for an environment can be stored within the same remote state location.
The last parameter will determine how many security groups will be created per service, this needs to be passed in as a list, i.e. ["WAS","WEB"]
Security groups will be created with the following naming convention in mind:

<Last4DigitsSubscriptionId>_<LogicalNameForSubscription>_NSG_<ServiceName>_<Function>

No translation to uppercase or lowercase will be done, so keep that in mind when passing in the variables
The wrapper.sh script handles the workspace changes and variable interpolation.
Note: Unexpected things might happen if the variables aren't set correctly
