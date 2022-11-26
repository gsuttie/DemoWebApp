@description('Required. Name of the site.')
param name string

@description('Optional. Location for all Resources.')
param location string

@description('Required. Type of site to deploy.')
@allowed([
  'app'
])
param kind string = 'app'

param appServicePlanName string 

resource app 'Microsoft.Web/sites@2020-12-01' = {
  name: name
  location: location
  kind: kind
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v6.0'
      appSettings: [
        { 
          name: 'EnvType'
          value: 'Production' 
        }
        { 
          name: 'SolutionVersion'
          value: 'v1.0'
        }
        {
          name: 'image'
          value: '/img/level200.png'
        }
      ]
    }
  }
}

resource appslot 'microsoft.web/sites/slots@2020-12-01' = {
  name: '${name}/dev'
  location: location
  kind: kind
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v6.0'
      appSettings: [
        { 
          name: 'EnvType'
          value: 'Development' 
        }
        { 
          name: 'SolutionVersion'
          value: 'v2.0'
        }
        {
          name: 'image'
          value: '/img/level300.png'
        }
      ]
    } 
  }
  dependsOn: [
    app
  ]
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName 
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}





