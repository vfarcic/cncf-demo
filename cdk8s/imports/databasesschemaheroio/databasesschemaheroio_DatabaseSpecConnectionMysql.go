// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysql struct {
	Collation *string `field:"optional" json:"collation" yaml:"collation"`
	Dbname *DatabaseSpecConnectionMysqlDbname `field:"optional" json:"dbname" yaml:"dbname"`
	DefaultCharset *string `field:"optional" json:"defaultCharset" yaml:"defaultCharset"`
	DisableTls *bool `field:"optional" json:"disableTls" yaml:"disableTls"`
	Host *DatabaseSpecConnectionMysqlHost `field:"optional" json:"host" yaml:"host"`
	Password *DatabaseSpecConnectionMysqlPassword `field:"optional" json:"password" yaml:"password"`
	Port *DatabaseSpecConnectionMysqlPort `field:"optional" json:"port" yaml:"port"`
	Uri *DatabaseSpecConnectionMysqlUri `field:"optional" json:"uri" yaml:"uri"`
	User *DatabaseSpecConnectionMysqlUser `field:"optional" json:"user" yaml:"user"`
}

