"app-backend": {
    attributes: {
        workload: definition: {
            apiVersion: "apps/v1"
            kind:       "Deployment"
        }
        status: healthPolicy: "isHealth: (context.output.status.readyReplicas > 0) && (context.output.status.readyReplicas == context.output.status.replicas)"
    }
    type: "component"
}

template: {
    parameter: {
        image:               string
        tag:                 string
        port:                *80 | int
        host:                *"devopstoolkit.live" | string
        ingressClassName:    string
        db: secret:          string
        db: secretNamespace: string
    }
    output: {
        apiVersion: "apps/v1"
        kind:       "Deployment"
        metadata: labels: "app.kubernetes.io/name": context.name
        spec: {
            selector: matchLabels: "app.kubernetes.io/name": context.name
            template: {
                metadata: labels: "app.kubernetes.io/name": context.name
                spec: containers: [{
                    image: parameter.image + ":" + parameter.tag
                    livenessProbe: httpGet: {
                        path: "/"
                        port: parameter.port
                    }
                    name: "backend"
                    ports: [{ containerPort: 80 }]
                    readinessProbe: httpGet: {
                        path: "/"
                        port: parameter.port
                    }
                    resources: {
                        limits: {
                            cpu:    "250m"
                            memory: "256Mi"
                        }
                        requests: {
                            cpu:    "125m"
                            memory: "128Mi"
                        }
                    }
                    if parameter.db.secret != _|_ {
                        env: [{
                            name: "DB_ENDPOINT"
                            valueFrom: secretKeyRef: {
                                key:  "endpoint"
                                name: parameter.db.secret
                            }
                        }, {
                            name: "DB_PASSWORD"
                            valueFrom: secretKeyRef: {
                                key:  "password"
                                name: parameter.db.secret
                            }
                        }, {
                            name: "DB_PORT"
                            valueFrom: secretKeyRef: {
                                key:      "port"
                                name:     parameter.db.secret
                                optional: true
                            }
                        }, {
                            name: "DB_USERNAME"
                            valueFrom: secretKeyRef: {
                                key:  "username"
                                name: parameter.db.secret
                            }
                        }, {
                            name:  "DB_NAME"
                            value: context.name
                        }]
                    }
                }]
            }
        }
    }
    outputs: {
        service: {
            apiVersion: "v1"
            kind:       "Service"
            metadata: {
                name:   context.name
                labels: "app.kubernetes.io/name": context.name
            }
            spec: {
                selector: "app.kubernetes.io/name": context.name
                type: "ClusterIP"
                ports: [{
                    port:       parameter.port
                    targetPort: parameter.port
                    protocol:   "TCP"
                    name:       "http"
                }]
            }
        }
        ingress: {
            apiVersion: "networking.k8s.io/v1"
            kind:       "Ingress"
            metadata: {
                name:        context.name
                labels:      "app.kubernetes.io/name": context.name
                annotations: "ingress.kubernetes.io/ssl-redirect": "false"
            }
            spec: {
                if parameter.ingressClassName != _|_ {
                    ingressClassName: parameter.ingressClassName
                }
                rules: [{
                    host: parameter.host
                    http: paths: [{
                        path:     "/"
                        pathType: "ImplementationSpecific"
                        backend: service: {
                            name:         context.name
                            port: number: parameter.port
                        }
                    }]
                }]
            }
        }
    }
}
