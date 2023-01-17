// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaSqliteColumns struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Type *string `field:"required" json:"type" yaml:"type"`
	Attributes *TableSpecSchemaSqliteColumnsAttributes `field:"optional" json:"attributes" yaml:"attributes"`
	Constraints *TableSpecSchemaSqliteColumnsConstraints `field:"optional" json:"constraints" yaml:"constraints"`
	Default *string `field:"optional" json:"default" yaml:"default"`
}

