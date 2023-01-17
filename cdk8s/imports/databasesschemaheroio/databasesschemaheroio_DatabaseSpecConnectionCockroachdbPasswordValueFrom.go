// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbPasswordValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbPasswordValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbPasswordValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbPasswordValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

