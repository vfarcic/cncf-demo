// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecTemplateMetadata struct {
	Annotations *map[string]*string `field:"optional" json:"annotations" yaml:"annotations"`
	Finalizers *[]*string `field:"optional" json:"finalizers" yaml:"finalizers"`
	Labels *map[string]*string `field:"optional" json:"labels" yaml:"labels"`
	Name *string `field:"optional" json:"name" yaml:"name"`
	Namespace *string `field:"optional" json:"namespace" yaml:"namespace"`
}

