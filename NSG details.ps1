$tenantId = "b1a7c303-0faf-4874-a764-0eb184efd96e"
$Subscscriptionfile ="/home/gowrishankar/clouddrive/subscription.csv"
$Subscriptionlist = Get-AzureRmSubscription -TenantId $tenantId 
$Subscriptionlist| Export-Csv "subscription.csv"


$SIDS = Import-Csv  $Subscscriptionfile #Importing the user file

$report=@()
foreach($SubscriptionIds in $SIDS) {
$subscriptionId = $SubscriptionIds.SubscriptionId
Write-Host "subscriptionName:" $SubscriptionIds.Name
#$FilePath = Read-Host "Please specify a path for the generated report"
Set-AzureRmContext -SubscriptionId $SubscriptionIds.SubscriptionId
 $nsg=Get-AzureRmNetworkInterface | Select Name, ResourceGroupName, Location,`
 @{Name="VMName";Expression = {$_.VirtualMachine.Id.tostring().substring($_.VirtualMachine.Id.tostring().lastindexof('/')+1)}},`
 @{Name="NSG";Expression = {$_.NetworkSecurityGroup.Id.tostring().substring($_.NetworkSecurityGroup.Id.tostring().lastindexof('/')+1)}},`
 @{Name="SubnetName";Expression = {$_.IpConfigurations.subnet.id.tostring().substring($_.IpConfigurations.subnet.id.tostring().lastindexof('/')+1)}}
 Write-Host $nsg
for($s=0; $s -lt $nsg.Count ; $s++)
{

$info = " " | Select SubscriptionName,ResourceGroupName,Location,VmName,NSG,Subnetname
$info.SubscriptionName=$SubscriptionIds.Name
$info.ResourceGroupName=$nsg[$s].ResourceGroupName
$info.Location=$nsg[$s].Location
$info.Vmname=$nsg[$s].VMName
$info.NSG=$nsg[$s].NSG
$info.Subnetname=$nsg[$s].Subnetname
 $report+= $info
}
$report | ft SubscriptionName,ResourceGroupName,Location,VmName,NSG,Subnetname
}
$report| Export-CSV "/home/gowrishankar/clouddrive/NSGlist.CSV" -NoTypeInformation



