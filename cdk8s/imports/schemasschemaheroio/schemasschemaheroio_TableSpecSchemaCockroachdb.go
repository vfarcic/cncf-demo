// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaCockroachdb struct {
	Columns *[]*TableSpecSchemaCockroachdbColumns `field:"optional" json:"columns" yaml:"columns"`
	ForeignKeys *[]*TableSpecSchemaCockroachdbForeignKeys `field:"optional" json:"foreignKeys" yaml:"foreignKeys"`
	Indexes *[]*TableSpecSchemaCockroachdbIndexes `field:"optional" json:"indexes" yaml:"indexes"`
	IsDeleted *bool `field:"optional" json:"isDeleted" yaml:"isDeleted"`
	PrimaryKey *[]*string `field:"optional" json:"primaryKey" yaml:"primaryKey"`
}

