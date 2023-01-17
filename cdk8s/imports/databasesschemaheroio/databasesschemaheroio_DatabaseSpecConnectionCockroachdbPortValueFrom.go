// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbPortValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbPortValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbPortValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbPortValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

