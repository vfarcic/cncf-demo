// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlDbnameValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlDbnameValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlDbnameValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlDbnameValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

