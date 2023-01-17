// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresDbnameValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresDbnameValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresDbnameValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresDbnameValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

