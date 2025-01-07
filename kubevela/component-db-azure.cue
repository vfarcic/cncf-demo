import "encoding/base64"

"db-azure": {
    attributes: {
        workload: definition: {
            apiVersion: "dbforpostgresql.azure.upbound.io/v1beta1"
            kind:       "Server"
        }
    }
    type: "component"
}

template: {
    parameter: {
        region:  *"eastus" | string
        size:    *"small" | string
        version: string
    }
    output: {
        apiVersion: "dbforpostgresql.azure.upbound.io/v1beta1"
        kind: "Server"
        metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        spec: {
            forProvider: {
                location: parameter.region
                version: parameter.version
                if parameter.size == "small" {
                    skuName: "B_Gen5_1"
                }
                if parameter.size == "medium" {
                    skuName: "GP_Gen5_2"
                }
                if parameter.size == "large" {
                    skuName: "GP_Gen5_8"
                }
                resourceGroupNameRef: name: context.name + "-" + context.namespace
                storageMb: 5120
                autoGrowEnabled: true
                sslEnforcementEnabled: false
                sslMinimalTlsVersionEnforced: "TLSEnforcementDisabled"
                administratorLogin: "postgres"
                administratorLoginPasswordSecretRef: {
                    name: context.name + "-password"
                    namespace: context.namespace
                    key: "password"
                }
                publicNetworkAccessEnabled: true
            }
            writeConnectionSecretToRef: {
                name: context.name
                namespace: context.namespace
            }
        }
    }
    outputs: {
        #Metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        resourceGroup: {
            apiVersion: "azure.upbound.io/v1beta1"
            kind: "ResourceGroup"
            metadata: #Metadata
            spec: forProvider: location: parameter.region
        }
        firewallRule: {
            apiVersion: "dbforpostgresql.azure.upbound.io/v1beta1"
            kind: "FirewallRule"
            metadata: #Metadata
            spec: forProvider: {
                startIpAddress: "0.0.0.0"
                endIpAddress: "255.255.255.255"
                resourceGroupNameRef: name: context.name + "-" + context.namespace
                serverNameRef: name: context.name + "-" + context.namespace
            }
        }
    }
}
