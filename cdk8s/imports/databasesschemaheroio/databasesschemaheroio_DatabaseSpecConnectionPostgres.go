// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgres struct {
	Dbname *DatabaseSpecConnectionPostgresDbname `field:"optional" json:"dbname" yaml:"dbname"`
	Host *DatabaseSpecConnectionPostgresHost `field:"optional" json:"host" yaml:"host"`
	Password *DatabaseSpecConnectionPostgresPassword `field:"optional" json:"password" yaml:"password"`
	Port *DatabaseSpecConnectionPostgresPort `field:"optional" json:"port" yaml:"port"`
	Schema *DatabaseSpecConnectionPostgresSchema `field:"optional" json:"schema" yaml:"schema"`
	Sslmode *DatabaseSpecConnectionPostgresSslmode `field:"optional" json:"sslmode" yaml:"sslmode"`
	Uri *DatabaseSpecConnectionPostgresUri `field:"optional" json:"uri" yaml:"uri"`
	User *DatabaseSpecConnectionPostgresUser `field:"optional" json:"user" yaml:"user"`
}

