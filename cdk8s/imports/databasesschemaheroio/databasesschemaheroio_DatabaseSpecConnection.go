// databasesschemaheroio
package databasesschemaheroio


// DatabaseConnection defines connection parameters for the database driver.
type DatabaseSpecConnection struct {
	Cassandra *DatabaseSpecConnectionCassandra `field:"optional" json:"cassandra" yaml:"cassandra"`
	Cockroachdb *DatabaseSpecConnectionCockroachdb `field:"optional" json:"cockroachdb" yaml:"cockroachdb"`
	Mysql *DatabaseSpecConnectionMysql `field:"optional" json:"mysql" yaml:"mysql"`
	Postgres *DatabaseSpecConnectionPostgres `field:"optional" json:"postgres" yaml:"postgres"`
	Sqlite *DatabaseSpecConnectionSqlite `field:"optional" json:"sqlite" yaml:"sqlite"`
}

