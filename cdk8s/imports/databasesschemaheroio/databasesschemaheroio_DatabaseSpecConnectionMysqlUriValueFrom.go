// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionMysqlUriValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionMysqlUriValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionMysqlUriValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionMysqlUriValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

