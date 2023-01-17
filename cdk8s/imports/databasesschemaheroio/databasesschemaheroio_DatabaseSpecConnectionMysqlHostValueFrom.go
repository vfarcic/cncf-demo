// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlHostValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlHostValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlHostValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlHostValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

