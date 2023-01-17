package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
	"gopkg.in/yaml.v2"
)

type MyChartProps struct {
	cdk8s.ChartProps
}

func main() {
	props := cdk8s.AppProps{
		RecordConstructMetadata: jsii.Bool(false),
	}
	app := cdk8s.NewApp(&props)
	NewCncfDemoChart(app, "cncf-demo", nil)
	app.Synth()
}

func NewCncfDemoChart(scope constructs.Construct, id string, props *MyChartProps) cdk8s.Chart {
	var cprops cdk8s.ChartProps
	if props != nil {
		cprops = props.ChartProps
	}
	appProps := &AppProps{}
	setValues("app.yaml", appProps)
	env := os.Getenv("ENVIRONMENT")
	if len(env) > 0 {
		file := fmt.Sprintf("app-%s.yaml", env)
		setValues(file, appProps)
	}
	chart := cdk8s.NewChart(scope, jsii.String(id), &cprops)
	NewApp(chart, jsii.String(id), appProps)
	return chart
}

func setValues(file string, appProps *AppProps) {
	yamlFile, err := ioutil.ReadFile(file)
	if err != nil {
		log.Printf("yamlFile.Get err   #%v ", err)
	}
	err = yaml.Unmarshal(yamlFile, appProps)
	if err != nil {
		log.Fatalf("Unmarshal: %v", err)
	}
}
