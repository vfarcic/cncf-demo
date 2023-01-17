// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlPasswordValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionMysqlPasswordValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

