// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlUriValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionMysqlUriValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

