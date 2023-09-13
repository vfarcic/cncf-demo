package externalsecretsio


type ExternalSecretSpecTargetTemplateTemplateFrom struct {
	ConfigMap *ExternalSecretSpecTargetTemplateTemplateFromConfigMap `field:"optional" json:"configMap" yaml:"configMap"`
	Secret *ExternalSecretSpecTargetTemplateTemplateFromSecret `field:"optional" json:"secret" yaml:"secret"`
}

