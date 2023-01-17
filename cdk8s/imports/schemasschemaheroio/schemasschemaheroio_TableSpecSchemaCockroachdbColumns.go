// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaCockroachdbColumns struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Type *string `field:"required" json:"type" yaml:"type"`
	Attributes *TableSpecSchemaCockroachdbColumnsAttributes `field:"optional" json:"attributes" yaml:"attributes"`
	Constraints *TableSpecSchemaCockroachdbColumnsConstraints `field:"optional" json:"constraints" yaml:"constraints"`
	Default *string `field:"optional" json:"default" yaml:"default"`
}

