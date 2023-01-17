// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlPasswordValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlPasswordValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlPasswordValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlPasswordValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

