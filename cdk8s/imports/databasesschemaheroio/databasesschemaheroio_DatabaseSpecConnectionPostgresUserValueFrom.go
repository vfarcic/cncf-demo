// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresUserValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresUserValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresUserValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresUserValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

