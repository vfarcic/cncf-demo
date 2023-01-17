// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchema struct {
	Cassandra *TableSpecSchemaCassandra `field:"optional" json:"cassandra" yaml:"cassandra"`
	Cockroachdb *TableSpecSchemaCockroachdb `field:"optional" json:"cockroachdb" yaml:"cockroachdb"`
	Mysql *TableSpecSchemaMysql `field:"optional" json:"mysql" yaml:"mysql"`
	Postgres *TableSpecSchemaPostgres `field:"optional" json:"postgres" yaml:"postgres"`
	Sqlite *TableSpecSchemaSqlite `field:"optional" json:"sqlite" yaml:"sqlite"`
}

