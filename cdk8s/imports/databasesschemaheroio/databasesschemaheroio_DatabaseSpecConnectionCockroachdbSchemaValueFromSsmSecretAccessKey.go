// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbSchemaValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCockroachdbSchemaValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

