$nsgname = "vm-rgpb1-nsg"
$resourceGroupName = "rgp-b"
$NSG = Get-AzureRmNetworkSecurityGroup -Name $nsgname`
                 -ResourceGroupName $resourceGroupName

foreach($rule in import-csv "inputfile.csv")
{ 
    $NSG | add-AzureRmNetworkSecurityRuleConfig -Name $rule.name `
           -Access Allow -Protocol Tcp -Direction $rule.direction -Priority $rule.priority `
           -SourceAddressPrefix $rule.source -SourcePortRange * `
           -DestinationAddressPrefix $rule.destination -DestinationPortRange $rule.port
}

$NSG | Set-AzureRmNetworkSecurityGroup