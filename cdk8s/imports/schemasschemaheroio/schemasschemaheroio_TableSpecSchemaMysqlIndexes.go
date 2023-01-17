// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaMysqlIndexes struct {
	Columns *[]*string `field:"required" json:"columns" yaml:"columns"`
	IsUnique *bool `field:"optional" json:"isUnique" yaml:"isUnique"`
	Name *string `field:"optional" json:"name" yaml:"name"`
	Type *string `field:"optional" json:"type" yaml:"type"`
}

