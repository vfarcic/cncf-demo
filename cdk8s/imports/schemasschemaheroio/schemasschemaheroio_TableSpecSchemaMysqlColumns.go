// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaMysqlColumns struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	Type *string `field:"required" json:"type" yaml:"type"`
	Attributes *TableSpecSchemaMysqlColumnsAttributes `field:"optional" json:"attributes" yaml:"attributes"`
	Charset *string `field:"optional" json:"charset" yaml:"charset"`
	Collation *string `field:"optional" json:"collation" yaml:"collation"`
	Constraints *TableSpecSchemaMysqlColumnsConstraints `field:"optional" json:"constraints" yaml:"constraints"`
	Default *string `field:"optional" json:"default" yaml:"default"`
}

