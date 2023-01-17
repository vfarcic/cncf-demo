// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresPasswordValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresPasswordValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresPasswordValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresPasswordValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

