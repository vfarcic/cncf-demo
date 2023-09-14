package externalsecretsio


type ExternalSecretV1Beta1SpecTargetTemplateTemplateFrom struct {
	ConfigMap *ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMap `field:"optional" json:"configMap" yaml:"configMap"`
	Literal *string `field:"optional" json:"literal" yaml:"literal"`
	Secret *ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecret `field:"optional" json:"secret" yaml:"secret"`
	Target *string `field:"optional" json:"target" yaml:"target"`
}

