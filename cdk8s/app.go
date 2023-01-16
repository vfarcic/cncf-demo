package main

import (
	"example.com/cdk8s/imports/k8s"
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
)

type AppProps struct {
	Image            string
	TlsEnabled       bool
	IngressClassName string
	IngressHost      string
}

func NewApp(scope constructs.Construct, id *string, appProps *AppProps) constructs.Construct {
	construct := constructs.NewConstruct(scope, id)
	labels := map[string]*string{
		"app.kubernetes.io/name": constructs.Node_Of(construct).Id(),
	}
	if appProps.TlsEnabled {
		labels["cert-manager.io/enabled"] = jsii.String("true")
	}
	metadata := &k8s.ObjectMeta{
		Name:   id,
		Labels: &labels,
	}
	k8s.NewKubeDeployment(construct, jsii.String("deployment"), getDeploymentProps(appProps, metadata))
	k8s.NewKubeService(construct, jsii.String("service"), getServiceProps(metadata))
	k8s.NewKubeIngress(construct, jsii.String("ingress"), getIngressProps(appProps, metadata))
	return construct
}

func getDeploymentProps(appProps *AppProps, metadata *k8s.ObjectMeta) *k8s.KubeDeploymentProps {
	return &k8s.KubeDeploymentProps{
		Metadata: metadata,
		Spec: &k8s.DeploymentSpec{
			Selector: &k8s.LabelSelector{MatchLabels: metadata.Labels},
			Template: &k8s.PodTemplateSpec{
				Metadata: metadata,
				Spec: &k8s.PodSpec{
					Containers: &[]*k8s.Container{{
						Name:  jsii.String("main"),
						Image: jsii.String(appProps.Image),
						Ports: &[]*k8s.ContainerPort{{ContainerPort: jsii.Number(8080)}},
						Resources: &k8s.ResourceRequirements{
							Limits: &map[string]k8s.Quantity{
								"cpu":    k8s.Quantity_FromString(jsii.String("500m")),
								"memory": k8s.Quantity_FromString(jsii.String("512Mi")),
							},
							Requests: &map[string]k8s.Quantity{
								"cpu":    k8s.Quantity_FromString(jsii.String("250m")),
								"memory": k8s.Quantity_FromString(jsii.String("256Mi")),
							},
						},
						LivenessProbe: &k8s.Probe{
							HttpGet: &k8s.HttpGetAction{
								Path: jsii.String("/"),
								Port: k8s.IntOrString_FromNumber(jsii.Number(8080)),
							},
						},
						ReadinessProbe: &k8s.Probe{
							HttpGet: &k8s.HttpGetAction{
								Path: jsii.String("/"),
								Port: k8s.IntOrString_FromNumber(jsii.Number(8080)),
							},
						},
					}},
				},
			},
		},
	}
}

func getServiceProps(metadata *k8s.ObjectMeta) *k8s.KubeServiceProps {
	return &k8s.KubeServiceProps{
		Metadata: metadata,
		Spec: &k8s.ServiceSpec{
			Type: jsii.String("ClusterIP"),
			Ports: &[]*k8s.ServicePort{{
				Port:       jsii.Number(8080),
				TargetPort: k8s.IntOrString_FromNumber(jsii.Number(8080)),
				Protocol:   jsii.String("TCP"),
				Name:       jsii.String("http"),
			}},
			Selector: metadata.Labels,
		},
	}
}

func getIngressProps(appProps *AppProps, metadata *k8s.ObjectMeta) *k8s.KubeIngressProps {
	kubeIngressProps := k8s.KubeIngressProps{
		Metadata: metadata,
		Spec: &k8s.IngressSpec{
			IngressClassName: &appProps.IngressClassName,
			Rules: &[]*k8s.IngressRule{{
				Host: jsii.String(appProps.IngressHost),
				Http: &k8s.HttpIngressRuleValue{
					Paths: &[]*k8s.HttpIngressPath{{
						Path:     jsii.String("/"),
						PathType: jsii.String("ImplementationSpecific"),
						Backend: &k8s.IngressBackend{
							Service: &k8s.IngressServiceBackend{
								Name: jsii.String(*metadata.Name),
								Port: &k8s.ServiceBackendPort{
									Number: jsii.Number(8080),
								},
							},
						},
					}},
				},
			}},
		},
	}
	if appProps.TlsEnabled {
		kubeIngressProps.Spec.Tls = &[]*k8s.IngressTls{{
			Hosts:      &[]*string{jsii.String(appProps.IngressHost)},
			SecretName: jsii.String(*metadata.Name),
		}}
	}
	return &kubeIngressProps
}
