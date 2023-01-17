// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandra struct {
	Hosts *[]*string `field:"required" json:"hosts" yaml:"hosts"`
	Keyspace *DatabaseSpecConnectionCassandraKeyspace `field:"required" json:"keyspace" yaml:"keyspace"`
	Password *DatabaseSpecConnectionCassandraPassword `field:"optional" json:"password" yaml:"password"`
	Username *DatabaseSpecConnectionCassandraUsername `field:"optional" json:"username" yaml:"username"`
}

