// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbUserValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbUserValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbUserValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbUserValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

