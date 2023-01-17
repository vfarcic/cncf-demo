// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbPasswordValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCockroachdbPasswordValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

