// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraKeyspaceValueFrom struct {
	SecretKeyRef *DatabaseSpecConnectionCassandraKeyspaceValueFromSecretKeyRef `field:"optional" json:"secretKeyRef" yaml:"secretKeyRef"`
	Ssm *DatabaseSpecConnectionCassandraKeyspaceValueFromSsm `field:"optional" json:"ssm" yaml:"ssm"`
	Vault *DatabaseSpecConnectionCassandraKeyspaceValueFromVault `field:"optional" json:"vault" yaml:"vault"`
}

