// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbUriValueFromSsm struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	AccessKeyId *DatabaseSpecConnectionCockroachdbUriValueFromSsmAccessKeyId `field:"optional" json:"accessKeyId" yaml:"accessKeyId"`
	Region *string `field:"optional" json:"region" yaml:"region"`
	SecretAccessKey *DatabaseSpecConnectionCockroachdbUriValueFromSsmSecretAccessKey `field:"optional" json:"secretAccessKey" yaml:"secretAccessKey"`
	WithDecryption *bool `field:"optional" json:"withDecryption" yaml:"withDecryption"`
}

