// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbUriValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbUriValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbUriValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbUriValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

