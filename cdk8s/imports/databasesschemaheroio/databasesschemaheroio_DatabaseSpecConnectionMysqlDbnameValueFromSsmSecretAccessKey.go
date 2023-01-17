// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlDbnameValueFromSsmSecretAccessKey struct {
	Value *string `field:"required" json:"value" yaml:"value"`
	ValueFrom *DatabaseSpecConnectionMysqlDbnameValueFromSsmSecretAccessKeyValueFrom `field:"optional" json:"valueFrom" yaml:"valueFrom"`
}

