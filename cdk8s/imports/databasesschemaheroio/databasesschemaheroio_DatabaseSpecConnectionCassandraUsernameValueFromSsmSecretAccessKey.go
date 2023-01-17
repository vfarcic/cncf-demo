// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraUsernameValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCassandraUsernameValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

