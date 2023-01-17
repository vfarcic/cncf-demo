// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraUsernameValueFromSsm struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	AccessKeyId *DatabaseSpecConnectionCassandraUsernameValueFromSsmAccessKeyId `field:"optional" json:"accessKeyId" yaml:"accessKeyId"`
	Region *string `field:"optional" json:"region" yaml:"region"`
	SecretAccessKey *DatabaseSpecConnectionCassandraUsernameValueFromSsmSecretAccessKey `field:"optional" json:"secretAccessKey" yaml:"secretAccessKey"`
	WithDecryption *bool `field:"optional" json:"withDecryption" yaml:"withDecryption"`
}

