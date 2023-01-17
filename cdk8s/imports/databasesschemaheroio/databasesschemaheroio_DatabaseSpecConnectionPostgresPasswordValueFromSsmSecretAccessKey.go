// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresPasswordValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionPostgresPasswordValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

