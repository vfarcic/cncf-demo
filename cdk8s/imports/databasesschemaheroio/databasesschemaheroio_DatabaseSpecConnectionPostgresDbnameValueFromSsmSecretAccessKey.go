// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresDbnameValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionPostgresDbnameValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

