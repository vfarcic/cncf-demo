// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbPasswordValueFromSsm struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	AccessKeyId *DatabaseSpecConnectionCockroachdbPasswordValueFromSsmAccessKeyId `field:"optional" json:"accessKeyId" yaml:"accessKeyId"`
	Region *string `field:"optional" json:"region" yaml:"region"`
	SecretAccessKey *DatabaseSpecConnectionCockroachdbPasswordValueFromSsmSecretAccessKey `field:"optional" json:"secretAccessKey" yaml:"secretAccessKey"`
	WithDecryption *bool `field:"optional" json:"withDecryption" yaml:"withDecryption"`
}

