// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbUriValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionCockroachdbUriValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

