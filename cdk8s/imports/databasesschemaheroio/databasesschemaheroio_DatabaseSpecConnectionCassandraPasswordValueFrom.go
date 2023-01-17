// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraPasswordValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCassandraPasswordValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCassandraPasswordValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCassandraPasswordValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

