// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaSqlite struct {
	Columns *[]*TableSpecSchemaSqliteColumns `field:"optional" json:"columns" yaml:"columns"`
	ForeignKeys *[]*TableSpecSchemaSqliteForeignKeys `field:"optional" json:"foreignKeys" yaml:"foreignKeys"`
	Indexes *[]*TableSpecSchemaSqliteIndexes `field:"optional" json:"indexes" yaml:"indexes"`
	IsDeleted *bool `field:"optional" json:"isDeleted" yaml:"isDeleted"`
	PrimaryKey *[]*string `field:"optional" json:"primaryKey" yaml:"primaryKey"`
}

