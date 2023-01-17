// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaMysql struct {
	Collation *string `field:"optional" json:"collation" yaml:"collation"`
	Columns *[]*TableSpecSchemaMysqlColumns `field:"optional" json:"columns" yaml:"columns"`
	DefaultCharset *string `field:"optional" json:"defaultCharset" yaml:"defaultCharset"`
	ForeignKeys *[]*TableSpecSchemaMysqlForeignKeys `field:"optional" json:"foreignKeys" yaml:"foreignKeys"`
	Indexes *[]*TableSpecSchemaMysqlIndexes `field:"optional" json:"indexes" yaml:"indexes"`
	IsDeleted *bool `field:"optional" json:"isDeleted" yaml:"isDeleted"`
	PrimaryKey *[]*string `field:"optional" json:"primaryKey" yaml:"primaryKey"`
}

