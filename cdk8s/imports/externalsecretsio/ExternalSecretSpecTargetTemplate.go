package externalsecretsio


// Template defines a blueprint for the created Secret resource.
type ExternalSecretSpecTargetTemplate struct {
	Data *map[string]*string `field:"optional" json:"data" yaml:"data"`
	// EngineVersion specifies the template engine version that should be used to compile/execute the template specified in .data and .templateFrom[].
	EngineVersion *string `field:"optional" json:"engineVersion" yaml:"engineVersion"`
	// ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.
	Metadata *ExternalSecretSpecTargetTemplateMetadata `field:"optional" json:"metadata" yaml:"metadata"`
	TemplateFrom *[]*ExternalSecretSpecTargetTemplateTemplateFrom `field:"optional" json:"templateFrom" yaml:"templateFrom"`
	Type *string `field:"optional" json:"type" yaml:"type"`
}

