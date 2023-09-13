package externalsecretsio


// ExternalSecretTarget defines the Kubernetes Secret to be created There can be only one target per ExternalSecret.
type ExternalSecretSpecTarget struct {
	// CreationPolicy defines rules on how to create the resulting Secret Defaults to 'Owner'.
	// Default: Owner'.
	//
	CreationPolicy *string `field:"optional" json:"creationPolicy" yaml:"creationPolicy"`
	// Immutable defines if the final secret will be immutable.
	Immutable *bool `field:"optional" json:"immutable" yaml:"immutable"`
	// Name defines the name of the Secret resource to be managed This field is immutable Defaults to the .metadata.name of the ExternalSecret resource.
	// Default: the .metadata.name of the ExternalSecret resource
	//
	Name *string `field:"optional" json:"name" yaml:"name"`
	// Template defines a blueprint for the created Secret resource.
	Template *ExternalSecretSpecTargetTemplate `field:"optional" json:"template" yaml:"template"`
}

