// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresPortValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresPortValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresPortValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresPortValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

