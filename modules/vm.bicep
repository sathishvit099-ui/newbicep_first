param vmName string
param location string

@secure()
param adminPassword string

param adminUserName string
param subnetId string

resource nic 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: '${vmName}-nic'
  location: location

  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'

        properties: {
          subnet: {
            id: subnetId
          }

          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: location

  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUserName
      adminPassword: adminPassword
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
