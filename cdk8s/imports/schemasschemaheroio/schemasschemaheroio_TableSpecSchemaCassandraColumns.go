// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaCassandraColumns struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Type *string `field:"required" json:"type" yaml:"type"`
	IsStatic *bool `field:"optional" json:"isStatic" yaml:"isStatic"`
}

