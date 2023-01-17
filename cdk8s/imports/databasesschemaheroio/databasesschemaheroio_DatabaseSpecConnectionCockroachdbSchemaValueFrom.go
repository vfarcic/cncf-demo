// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCockroachdbSchemaValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCockroachdbSchemaValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCockroachdbSchemaValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCockroachdbSchemaValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

