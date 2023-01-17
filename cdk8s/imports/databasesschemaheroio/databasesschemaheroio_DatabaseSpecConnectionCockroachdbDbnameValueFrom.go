// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbDbnameValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbDbnameValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbDbnameValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbDbnameValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

