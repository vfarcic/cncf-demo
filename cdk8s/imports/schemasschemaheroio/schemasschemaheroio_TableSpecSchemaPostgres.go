// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaPostgres struct {
	Columns *[]*TableSpecSchemaPostgresColumns `field:"optional" json:"columns" yaml:"columns"`
	ForeignKeys *[]*TableSpecSchemaPostgresForeignKeys `field:"optional" json:"foreignKeys" yaml:"foreignKeys"`
	Indexes *[]*TableSpecSchemaPostgresIndexes `field:"optional" json:"indexes" yaml:"indexes"`
	IsDeleted *bool `field:"optional" json:"isDeleted" yaml:"isDeleted"`
	PrimaryKey *[]*string `field:"optional" json:"primaryKey" yaml:"primaryKey"`
}

