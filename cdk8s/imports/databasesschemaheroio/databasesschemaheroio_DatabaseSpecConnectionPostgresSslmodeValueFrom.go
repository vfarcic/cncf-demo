// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionPostgresSslmodeValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionPostgresSslmodeValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionPostgresSslmodeValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionPostgresSslmodeValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

