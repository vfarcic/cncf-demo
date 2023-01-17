// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecSchemahero struct {
	Image *string `field:"optional" json:"image" yaml:"image"`
	NodeSelector *map[string]*string `field:"optional" json:"nodeSelector" yaml:"nodeSelector"`
}

