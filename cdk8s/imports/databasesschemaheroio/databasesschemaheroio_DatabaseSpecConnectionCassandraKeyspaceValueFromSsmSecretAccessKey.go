// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraKeyspaceValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCassandraKeyspaceValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

