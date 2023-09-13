package externalsecretsio


// Template defines a blueprint for the created Secret resource.
type ExternalSecretV1Beta1SpecTargetTemplate struct {
	Data *map[string]*string `field:"optional" json:"data" yaml:"data"`
	EngineVersion *string `field:"optional" json:"engineVersion" yaml:"engineVersion"`
	// ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.
	Metadata *ExternalSecretV1Beta1SpecTargetTemplateMetadata `field:"optional" json:"metadata" yaml:"metadata"`
	TemplateFrom *[]*ExternalSecretV1Beta1SpecTargetTemplateTemplateFrom `field:"optional" json:"templateFrom" yaml:"templateFrom"`
	Type *string `field:"optional" json:"type" yaml:"type"`
}

