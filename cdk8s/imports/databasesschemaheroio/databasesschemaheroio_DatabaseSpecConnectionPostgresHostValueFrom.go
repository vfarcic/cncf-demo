// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresHostValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresHostValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresHostValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresHostValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

