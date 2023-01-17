// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaMysqlForeignKeys struct {
	Columns *[]*string `field:"required" json:"columns" yaml:"columns"`
	References *TableSpecSchemaMysqlForeignKeysReferences `field:"required" json:"references" yaml:"references"`
	Name *string `field:"optional" json:"name" yaml:"name"`
	OnDelete *string `field:"optional" json:"onDelete" yaml:"onDelete"`
}

