// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbHostValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbHostValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbHostValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbHostValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

