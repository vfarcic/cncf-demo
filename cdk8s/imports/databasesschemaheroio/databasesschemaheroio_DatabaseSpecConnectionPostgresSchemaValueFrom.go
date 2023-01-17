// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresSchemaValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresSchemaValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresSchemaValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresSchemaValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

