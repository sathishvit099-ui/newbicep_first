targetScope = 'resourceGroup'

param location string

param vnetName string
param nsgName string
param storageAccountName string

param vmName string
param adminUserName string

@secure()
param adminPassword string

module vnet './modules/vnet.bicep' = {
  name: 'vnetDeploy'

  params: {
    vnetName: vnetName
    location: location
  }
}

module nsg './modules/nsg.bicep' = {
  name: 'nsgDeploy'

  params: {
    nsgName: nsgName
    location: location
  }
}

module storage './modules/storage.bicep' = {
  name: 'storageDeploy'

  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module vm './modules/vm.bicep' = {
  name: 'vmDeploy'

  params: {
    vmName: vmName
    adminUserName: adminUserName
    adminPassword: adminPassword

    location: location
    subnetId: vnet.outputs.subnetId
  }

