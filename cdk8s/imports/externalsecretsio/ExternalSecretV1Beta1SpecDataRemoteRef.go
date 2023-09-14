package externalsecretsio


// RemoteRef points to the remote secret and defines which secret (version/property/..) to fetch.
type ExternalSecretV1Beta1SpecDataRemoteRef struct {
	// Key is the key used in the Provider, mandatory.
	Key *string `field:"required" json:"key" yaml:"key"`
	// Used to define a conversion Strategy.
	ConversionStrategy *string `field:"optional" json:"conversionStrategy" yaml:"conversionStrategy"`
	// Used to define a decoding Strategy.
	DecodingStrategy *string `field:"optional" json:"decodingStrategy" yaml:"decodingStrategy"`
	// Policy for fetching tags/labels from provider secrets, possible options are Fetch, None.
	//
	// Defaults to None.
	// Default: None.
	//
	MetadataPolicy *string `field:"optional" json:"metadataPolicy" yaml:"metadataPolicy"`
	// Used to select a specific property of the Provider value (if a map), if supported.
	Property *string `field:"optional" json:"property" yaml:"property"`
	// Used to select a specific version of the Provider value, if supported.
	Version *string `field:"optional" json:"version" yaml:"version"`
}

