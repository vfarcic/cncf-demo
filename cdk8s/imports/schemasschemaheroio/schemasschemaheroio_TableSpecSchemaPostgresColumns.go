// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaPostgresColumns struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Type *string `field:"required" json:"type" yaml:"type"`
	Attributes *TableSpecSchemaPostgresColumnsAttributes `field:"optional" json:"attributes" yaml:"attributes"`
	Constraints *TableSpecSchemaPostgresColumnsConstraints `field:"optional" json:"constraints" yaml:"constraints"`
	Default *string `field:"optional" json:"default" yaml:"default"`
}

