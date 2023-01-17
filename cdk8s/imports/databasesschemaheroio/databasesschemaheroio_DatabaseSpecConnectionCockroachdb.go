// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdb struct {
	Dbname *DatabaseSpecConnectionCockroachdbDbname `field:"optional" json:"dbname" yaml:"dbname"`
	Host *DatabaseSpecConnectionCockroachdbHost `field:"optional" json:"host" yaml:"host"`
	Password *DatabaseSpecConnectionCockroachdbPassword `field:"optional" json:"password" yaml:"password"`
	Port *DatabaseSpecConnectionCockroachdbPort `field:"optional" json:"port" yaml:"port"`
	Schema *DatabaseSpecConnectionCockroachdbSchema `field:"optional" json:"schema" yaml:"schema"`
	Sslmode *DatabaseSpecConnectionCockroachdbSslmode `field:"optional" json:"sslmode" yaml:"sslmode"`
	Uri *DatabaseSpecConnectionCockroachdbUri `field:"optional" json:"uri" yaml:"uri"`
	User *DatabaseSpecConnectionCockroachdbUser `field:"optional" json:"user" yaml:"user"`
}

