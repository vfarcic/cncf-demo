// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraPasswordValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCassandraPasswordValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

