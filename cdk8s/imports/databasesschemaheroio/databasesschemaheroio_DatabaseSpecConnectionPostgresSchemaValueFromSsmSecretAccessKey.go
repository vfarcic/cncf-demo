// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresSchemaValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionPostgresSchemaValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

