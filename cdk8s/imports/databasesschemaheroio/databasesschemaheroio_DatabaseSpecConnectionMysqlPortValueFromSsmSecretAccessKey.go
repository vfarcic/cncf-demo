// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlPortValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionMysqlPortValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

