
targetScope = 'resourceGroup'

@allowed([
  'westeurope'
])
param location string = 'westeurope'
param customerName string = 'cloudadventures'

param guidPerResourceGroup string = guid(resourceGroup().id)

param randomstring string = '${take('app${guidPerResourceGroup}', 5)}'

module appservice 'modules/appservice.bicep' = {
  name: randomstring
  params: {
    appServicePlanName: 'asp-${customerName}'
    name: randomstring
    location: location
  }
}




