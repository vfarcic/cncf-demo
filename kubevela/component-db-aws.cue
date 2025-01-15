import "encoding/base64"

"db-aws": {
    attributes: {
        workload: definition: {
            apiVersion: "rds.aws.upbound.io/v1beta2"
            kind:       "Instance"
        }
        // status: healthPolicy: "isHealth: (context.output.status.readyReplicas > 0) && (context.output.status.readyReplicas == context.output.status.replicas)"
    }
    type: "component"
}

template: {
    parameter: {
        region:  *"us-east-1" | string
        size:    *"small" | string
        version: string
    }
    output: {
        apiVersion: "rds.aws.upbound.io/v1beta2"
        kind: "Instance"
        metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        spec: forProvider: {
            region: parameter.region
            dbSubnetGroupNameRef: name: context.name + "-" + context.namespace
            vpcSecurityGroupIdRef: name: context.name + "-" + context.namespace
            username: "masteruser"
            engine: "postgres"
            skipFinalSnapshot: true
            publiclyAccessible: true
            allocatedStorage: 200
            passwordSecretRef: {
                name: context.name + "-password"
                namespace: context.namespace
                key: "password"
            }
            identifier: context.name + "-" + context.namespace
            if parameter.size == "small" {
                instanceClass: "db.m5.large"
            }
            if parameter.size == "medium" {
                instanceClass: "db.m5.2xlarge"
            }
            if parameter.size == "large" {
                instanceClass: "db.m5.8xlarge"
            }
            engineVersion: parameter.version
        }
    }
    outputs: {
        #Metadata: {
            name:   context.name + "-" + context.namespace
            labels: "app.kubernetes.io/name": context.name
        }
        vpc: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind:       "VPC"
            metadata: #Metadata
            spec: forProvider: {
                region:             parameter.region
                cidrBlock:          "11.0.0.0/16"
                enableDnsSupport:   true
                enableDnsHostnames: true
            }
        }
        internetGateway: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind:       "InternetGateway"
            metadata: #Metadata
            spec: forProvider: {
                region:   parameter.region
                vpcIdRef: name: context.name + "-" + context.namespace
            }
        }
        routeTable: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind: "RouteTable"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                vpcIdRef: name: context.name + "-" + context.namespace
            }
        }
        mainRouteTableAssociation: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind: "MainRouteTableAssociation"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                routeTableIdRef: name: context.name + "-" + context.namespace
                vpcIdRef: name: context.name + "-" + context.namespace
            }
        }
        route: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind: "Route"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                routeTableIdRef: name: context.name + "-" + context.namespace
                destinationCidrBlock: "0.0.0.0/0"
                gatewayIdRef: name: context.name + "-" + context.namespace
            }
        }
        securityGroup: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind: "SecurityGroup"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                description: "I am too lazy to write descriptions"
                vpcIdRef: name: context.name + "-" + context.namespace
            }
        }
        securityGroupRule: {
            apiVersion: "ec2.aws.upbound.io/v1beta1"
            kind: "SecurityGroupRule"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                description: "I am too lazy to write descriptions"
                type: "ingress"
                fromPort: 5432
                toPort: 5432
                protocol: "tcp"
                cidrBlocks: ["0.0.0.0/0"]
                securityGroupIdRef: name: context.name + "-" + context.namespace
            }
        }
        _zoneList: [
            { zone: "a", cidrBlock: "11.0.0.0/24" },
            { zone: "b", cidrBlock: "11.0.1.0/24"  },
            { zone: "c", cidrBlock: "11.0.2.0/24"  }
        ]
        for k, v in _zoneList {
            "subnet\(v.zone)": {
                apiVersion: "ec2.aws.upbound.io/v1beta1"
                kind: "Subnet"
                metadata: {
                    name:   context.name + "-" + v.zone + "-" + context.namespace
                    labels: {
                        "app.kubernetes.io/name": context.name
                        zone: parameter.region + v.zone
                    }
                }
                spec: forProvider: {
                    region: parameter.region
                    availabilityZone: parameter.region + v.zone
                    cidrBlock: v.cidrBlock
                    vpcIdRef: name: context.name + "-" + context.namespace
                }
            }
        }
        for k, v in _zoneList {
            "routeTableAssociation\(v.zone)": {
                apiVersion: "ec2.aws.upbound.io/v1beta1"
                kind: "RouteTableAssociation"
                metadata: {
                    name:   context.name + "-" + v.zone + "-" + context.namespace
                    labels: "app.kubernetes.io/name": context.name
                }
                spec: forProvider: {
                    region: parameter.region
                    routeTableIdRef: name: context.name + "-" + context.namespace
                    subnetIdSelector: {
                        matchLabels: {
                            "app.kubernetes.io/name": context.name
                            zone: parameter.region + v.zone
                        }
                    }
                }
            }
        }
        subnetGroup: {
            apiVersion: "rds.aws.upbound.io/v1beta1"
            kind: "SubnetGroup"
            metadata: #Metadata
            spec: forProvider: {
                region: parameter.region
                description: "I'm too lazy to write a good description"
                subnetIdRefs: [
                    for k, v in _zoneList {
                        name: context.name + "-" + v.zone + "-" + context.namespace
                    }
                ]
            }
        }
        secret: {
            apiVersion: "kubernetes.crossplane.io/v1alpha2"
            kind: "Object"
            metadata: #Metadata
            spec: {
                references:  [{
                    patchesFrom: {
                        apiVersion: "rds.aws.upbound.io/v1beta1"
                        kind:       "Instance"
                        name:       context.name + "-" + context.namespace
                        namespace:  "crossplane-system"
                        fieldPath:  "spec.forProvider.username"
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
                        apiVersion: "rds.aws.upbound.io/v1beta1"
                        kind:       "Instance"
                        name:       context.name + "-" + context.namespace
                        namespace:  "crossplane-system"
                        fieldPath:  "status.atProvider.address"
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
