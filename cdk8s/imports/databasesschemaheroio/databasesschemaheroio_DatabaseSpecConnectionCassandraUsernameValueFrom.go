// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraUsernameValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCassandraUsernameValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCassandraUsernameValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCassandraUsernameValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

