#!/bin/bash -e

# Convert Rundeck input into something that Terraform wants
functions="[\"${RD_OPTION_FUNCTIONS//,/\",\"}\"]"

if [[ ${RD_OPTION_ENV,,} == "pro" ]]; then
    object="Cloud Service-AzurePasswordManagement-SPN_PRO_SVC_NSG-PROVISIONING"
else
    object="Cloud Service-AzurePasswordManagement-SPN_NONPRO_SVC_NSG-PROVISIONING-SPN_NONPRO_SVC_NSG-PROVISIONING"
fi

query="safe=172B_PRB_P_CLD_AWS_LA_RT_M;object=${object};folder=root"
app_id='AIM_CloudTeam'
output='Password,PassProps.ApplicationID'
delimiter='#@#'

read -r secret id < <(/opt/CARKaim/sdk/clipasswordsdk GetPassword -p AppDescs.AppID="${app_id}" -p Query="${query}" -o "${output}" -d "${delimiter}" | awk -F "${delimiter}" '{print $1,$2}')

export http_proxy=http://b2bproxy.santanderuk.corp:80
export https_proxy=http://b2bproxy.santanderuk.corp:80

subscription_abbr=${RD_OPTION_SUBSCRIPTION_ID: -4}

../bin/terraform init
if ../bin/terraform workspace list | grep -sqw "${subscription_abbr}_${RD_OPTION_SERVICENAME}"; then
    ../bin/terraform workspace select "${subscription_abbr}_${RD_OPTION_SERVICENAME}"
else
    ../bin/terraform workspace new "${subscription_abbr}_${RD_OPTION_SERVICENAME}"
fi


export ARM_SUBSCRIPTION_ID=${RD_OPTION_SUBSCRIPTION_ID}
export ARM_CLIENT_ID=${id}
export ARM_CLIENT_SECRET=${secret}
../bin/terraform apply -var="functions=${functions}" -auto-approve
