// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlUserValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlUserValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlUserValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlUserValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

