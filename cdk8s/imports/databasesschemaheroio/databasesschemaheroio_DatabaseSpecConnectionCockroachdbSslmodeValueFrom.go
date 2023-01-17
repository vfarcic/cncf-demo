// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbSslmodeValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbSslmodeValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbSslmodeValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbSslmodeValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

