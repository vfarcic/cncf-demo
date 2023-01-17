// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresUriValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresUriValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresUriValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresUriValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

