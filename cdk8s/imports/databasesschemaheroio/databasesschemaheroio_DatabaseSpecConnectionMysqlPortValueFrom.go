// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlPortValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlPortValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlPortValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlPortValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

