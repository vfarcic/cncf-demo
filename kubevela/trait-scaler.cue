scaler: {
    attributes: {
        podDisruptive: false
    }
    type: "trait"
}

template: {
    parameter: {
        min: *1 | int
        max: *10 | int
    }
    outputs: {
        hpa: {
            apiVersion: "autoscaling/v2"
            kind: "HorizontalPodAutoscaler"
            metadata: {
                name:   context.name
                labels: "app.kubernetes.io/name": context.name
            }
            spec: {
                scaleTargetRef: {
                    apiVersion: "apps/v1"
                    kind:       "Deployment"
                    name:       context.name
                }
                minReplicas: parameter.min
                maxReplicas: parameter.max
                metrics: [{
                    type: "Resource"
                    resource: {
                        name: "cpu"
                        target: {
                            type: "Utilization"
                            averageUtilization: 80
                        }
                    }
                }, {
                    type: "Resource"
                    resource: {
                        name: "memory"
                        target: {
                            type: "Utilization"
                            averageUtilization: 80
                        }
                    }
                }]
            }
        }
    }
}
