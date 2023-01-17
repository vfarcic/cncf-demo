// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbUserValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCockroachdbUserValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

