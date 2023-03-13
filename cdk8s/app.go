package main

import (
	"example.com/cdk8s/imports/certmanagerio"
	shdb "example.com/cdk8s/imports/databasesschemaheroio"
	dot "example.com/cdk8s/imports/devopstoolkitseriescom"
	"example.com/cdk8s/imports/k8s"
	sht "example.com/cdk8s/imports/schemasschemaheroio"
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

type AppProps struct {
	Name       string     `yaml:"name"`
	Image      Image      `yaml:"image"`
	Ingress    Ingress    `yaml:"ingress"`
	Tls        Tls        `yaml:"tls"`
	Db         Db         `yaml:"db"`
	SchemaHero SchemaHero `yaml:"schemahero"`
}

type Image struct {
	Repository string `yaml:"repository"`
	Tag        string `yaml:"tag"`
}

type Ingress struct {
	Host      string `yaml:"host"`
	ClassName string `yaml:"className"`
}

type Tls struct {
	Enabled bool `yaml:"enabled"`
}

type Db struct {
	Id       string    `yaml:"id"`
	Insecure bool      `yaml:"insecure"`
	Enabled  DbEnabled `yaml:"enabled"`
}

type DbEnabled struct {
	Helm       bool         `yaml:"helm"`
	Crossplane DbCrossplane `yaml:"crossplane"`
}

type DbCrossplane struct {
	Local  bool `yaml:"local"`
	Google bool `yaml:"google"`
	AWS    bool `yaml:"aws"`
	Azure  bool `yaml:"azure"`
}

type SchemaHero struct {
	Enabled bool `yaml:"enabled"`
}

func NewApp(scope constructs.Construct, id *string, appProps *AppProps) constructs.Construct {
	construct := constructs.NewConstruct(scope, id)
	labels := map[string]*string{
		"app.kubernetes.io/name": constructs.Node_Of(construct).Id(),
	}
	apiMetadata := &cdk8s.ApiObjectMetadata{
		Name:   id,
		Labels: &labels,
	}
	metadata := &k8s.ObjectMeta{
		Name:   id,
		Labels: &labels,
	}
	k8s.NewKubeDeployment(construct, jsii.String("deployment"), getDeploymentProps(appProps, metadata))
	k8s.NewKubeService(construct, jsii.String("service"), getServiceProps(metadata))
	k8s.NewKubeIngress(construct, jsii.String("ingress"), getIngressProps(appProps, metadata))
	if appProps.Tls.Enabled {
		certmanagerio.NewCertificate(construct, jsii.String("certificate"), getCertificate(appProps, apiMetadata))
	}
	if appProps.Db.Enabled.Helm {
		cdk8s.NewHelm(construct, jsii.String("postgresql"), getPostgresqlHelm(appProps))
	} else if appProps.Db.Enabled.Crossplane.Local || appProps.Db.Enabled.Crossplane.Google || appProps.Db.Enabled.Crossplane.AWS || appProps.Db.Enabled.Crossplane.Azure {
		dot.NewSqlClaim(construct, jsii.String("sqlClaim"), getPostgresqlCrossplane(appProps, apiMetadata))
		if !appProps.Db.Enabled.Crossplane.Local && appProps.Db.Insecure {
			k8s.NewKubeSecret(construct, jsii.String("secret"), getPostgresqlSecret(appProps))
		}
	}
	if appProps.SchemaHero.Enabled {
		shdb.NewDatabase(construct, jsii.String("database"), getPostgresqlDatabase(appProps, apiMetadata))
		sht.NewTable(construct, jsii.String("table"), getPostgresqlTable(appProps, apiMetadata))
	}
	return construct
}

func getDeploymentProps(appProps *AppProps, metadata *k8s.ObjectMeta) *k8s.KubeDeploymentProps {
	container := k8s.Container{
		Name:  jsii.String("main"),
		Image: jsii.String(appProps.Image.Repository + ":" + appProps.Image.Tag),
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
	}
	setDbEnv(appProps, &container)
	return &k8s.KubeDeploymentProps{
		Metadata: metadata,
		Spec: &k8s.DeploymentSpec{
			Selector: &k8s.LabelSelector{MatchLabels: metadata.Labels},
			Template: &k8s.PodTemplateSpec{
				Metadata: metadata,
				Spec: &k8s.PodSpec{
					Containers: &[]*k8s.Container{&container},
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
			IngressClassName: &appProps.Ingress.ClassName,
			Rules: &[]*k8s.IngressRule{{
				Host: jsii.String(appProps.Ingress.Host),
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
	if appProps.Tls.Enabled {
		kubeIngressProps.Spec.Tls = &[]*k8s.IngressTls{{
			Hosts:      &[]*string{jsii.String(appProps.Ingress.Host)},
			SecretName: jsii.String(*metadata.Name),
		}}
		if appProps.Tls.Enabled {
			labels := map[string]*string{
				"app.kubernetes.io/name":  metadata.Name,
				"cert-manager.io/enabled": jsii.String("true"),
			}
			kubeIngressProps.Metadata.Labels = &labels
		}
	}
	return &kubeIngressProps
}

func getCertificate(appProps *AppProps, metadata *cdk8s.ApiObjectMetadata) *certmanagerio.CertificateProps {
	return &certmanagerio.CertificateProps{
		Metadata: metadata,
		Spec: &certmanagerio.CertificateSpec{
			SecretName: jsii.String(*metadata.Name),
			IssuerRef: &certmanagerio.CertificateSpecIssuerRef{
				Kind: jsii.String("ClusterIssuer"),
				Name: jsii.String("production"),
			},
			CommonName: jsii.String(appProps.Ingress.Host),
			DnsNames:   &[]*string{jsii.String(appProps.Ingress.Host)},
		},
	}
}
