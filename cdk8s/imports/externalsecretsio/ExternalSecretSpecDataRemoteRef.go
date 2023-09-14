package externalsecretsio


// ExternalSecretDataRemoteRef defines Provider data location.
type ExternalSecretSpecDataRemoteRef struct {
	// Key is the key used in the Provider, mandatory.
	Key *string `field:"required" json:"key" yaml:"key"`
	// Used to define a conversion Strategy.
	ConversionStrategy *string `field:"optional" json:"conversionStrategy" yaml:"conversionStrategy"`
	// Used to select a specific property of the Provider value (if a map), if supported.
	Property *string `field:"optional" json:"property" yaml:"property"`
	// Used to select a specific version of the Provider value, if supported.
	Version *string `field:"optional" json:"version" yaml:"version"`
}

