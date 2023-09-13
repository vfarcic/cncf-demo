package externalsecretsio


// ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.
type ExternalSecretV1Beta1SpecTargetTemplateMetadata struct {
	Annotations *map[string]*string `field:"optional" json:"annotations" yaml:"annotations"`
	Labels *map[string]*string `field:"optional" json:"labels" yaml:"labels"`
}

