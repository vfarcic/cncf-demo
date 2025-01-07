import "encoding/base64"

"db-google": {
    attributes: {
        workload: definition: {
            apiVersion: "sql.gcp.upbound.io/v1beta1"
            kind:       "DatabaseInstance"
        }
    }
    type: "component"
}

template: {
    parameter: {
        region:  *"us-east1" | string
        size:    *"small" | string
        version: string
    }
    output: {
        apiVersion: "sql.gcp.upbound.io/v1beta1"
        kind: "DatabaseInstance"
        metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        spec: {
            forProvider: {
                region:          parameter.region
                databaseVersion: "POSTGRES_" + parameter.version
                rootPasswordSecretRef: {
                    name:      context.name + "-password"
                    namespace: context.namespace
                    key:       "password"
                }
                settings: [{
                    if parameter.size == "small" {
                        tier: "db-custom-1-3840"
                    }
                    if parameter.size == "medium" {
                        tier: "db-custom-16-61440"
                    }
                    if parameter.size == "large" {
                        tier: "db-custom-64-245760"
                    }
                    availabilityType: "REGIONAL"
                    backupConfiguration: [{
                        enabled:          true
                        binaryLogEnabled: false
                    }]
                    ipConfiguration: [{
                        ipv4Enabled: true
                        authorizedNetworks: [{
                            name:  "all"
                            value: "0.0.0.0/0"
                        }]
                    }]
                }]
                deletionProtection: false
            }
        }
    }
    outputs: {
        #Metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        user: {
            apiVersion: "sql.gcp.upbound.io/v1beta1"
            kind:       "User"
            metadata:   #Metadata
            spec: {
                deletionPolicy: "Orphan"
                forProvider: {
                passwordSecretRef: {
                    name:      context.name + "-password"
                    namespace: context.namespace
                    key:       "password"
                }
                instanceRef: name: context.name + "-" + context.namespace
                }
            }
        }
        secret: {
            apiVersion: "kubernetes.crossplane.io/v1alpha2"
            kind:       "Object"
            metadata:   #Metadata
            spec: {
                references: [{
                    patchesFrom: {
                        apiVersion: "sql.gcp.upbound.io/v1beta1"
                        kind:       "User"
                        name:       context.name + "-" + context.namespace
                        namespace:  "crossplane-system"
                        fieldPath:  "metadata.name"
                    }
                    toFieldPath: "stringData.username"
                }, {
                    patchesFrom: {
                        apiVersion: "v1"
                        kind:       "Secret"
                        name:       context.name + "-password"
                        namespace:  context.namespace
                        fieldPath:  "data.password"
                    }
                    toFieldPath: "data.password"
                }, {
                    patchesFrom: {
                        apiVersion: "sql.gcp.upbound.io/v1beta1"
                        kind:       "DatabaseInstance"
                        name:       context.name + "-" + context.namespace
                        namespace:  "crossplane-system"
                        fieldPath:  "status.atProvider.publicIpAddress"
                    }
                    toFieldPath: "stringData.endpoint"
                }]
                forProvider: manifest: {
                    apiVersion: "v1"
                    kind:       "Secret"
                    metadata: {
                        name:      context.name
                        namespace: context.namespace
                    }
                    data: port: "NTQzMg=="
                }
            }
        }
    }
}
