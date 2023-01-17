// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaSqliteForeignKeys struct {
	Columns *[]*string `field:"required" json:"columns" yaml:"columns"`
	References *TableSpecSchemaSqliteForeignKeysReferences `field:"required" json:"references" yaml:"references"`
	Name *string `field:"optional" json:"name" yaml:"name"`
	OnDelete *string `field:"optional" json:"onDelete" yaml:"onDelete"`
}

