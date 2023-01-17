// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpecConnectionCassandraPasswordValueFromVault struct {
	Role *string `field:"required" json:"role" yaml:"role"`
	Secret *string `field:"required" json:"secret" yaml:"secret"`
	AgentInject *bool `field:"optional" json:"agentInject" yaml:"agentInject"`
	ConnectionTemplate *string `field:"optional" json:"connectionTemplate" yaml:"connectionTemplate"`
	Endpoint *string `field:"optional" json:"endpoint" yaml:"endpoint"`
	KubernetesAuthEndpoint *string `field:"optional" json:"kubernetesAuthEndpoint" yaml:"kubernetesAuthEndpoint"`
	ServiceAccount *string `field:"optional" json:"serviceAccount" yaml:"serviceAccount"`
	ServiceAccountNamespace *string `field:"optional" json:"serviceAccountNamespace" yaml:"serviceAccountNamespace"`
}

