package main

import (
	"os"

	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

type MyChartProps struct {
	cdk8s.ChartProps
}

func NewCncfDemoChart(scope constructs.Construct, id string, props *MyChartProps) cdk8s.Chart {
	var cprops cdk8s.ChartProps
	if props != nil {
		cprops = props.ChartProps
	}
	chart := cdk8s.NewChart(scope, jsii.String(id), &cprops)
	image := "vfarcic/cncf-demo"
	if os.Getenv("IMAGE") != "" {
		image = os.Getenv("IMAGE")
	}
	if os.Getenv("TAG") == "" {
		image += ":latest"
	} else {
		image += ":" + os.Getenv("TAG")
	}
	tlsEnabled := false
	if os.Getenv("TLS_ENABLED") == "true" {
		tlsEnabled = true
	}
	ingressClassName := "traefik"
	if os.Getenv("INGRESS_CLASS_NAME") != "" {
		ingressClassName = os.Getenv("INGRESS_CLASS_NAME")
	}
	ingressHost := "cncf-demo-dev.sillydemo.com"
	if os.Getenv("FULL_DOMAIN") != "" {
		ingressHost = os.Getenv("FULL_DOMAIN")
	}
	NewApp(
		chart,
		jsii.String(id),
		&AppProps{
			Image:            image,
			TlsEnabled:       tlsEnabled,
			IngressClassName: ingressClassName,
			IngressHost:      ingressHost,
		},
	)
	return chart
}

func main() {
	props := cdk8s.AppProps{
		RecordConstructMetadata: jsii.Bool(false),
	}
	app := cdk8s.NewApp(&props)
	NewCncfDemoChart(app, "cncf-demo", nil)
	app.Synth()
}
