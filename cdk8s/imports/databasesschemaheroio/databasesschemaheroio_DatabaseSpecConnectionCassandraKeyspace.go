// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraKeyspace struct {
	Value *string `field:"optional" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCassandraKeyspaceValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

