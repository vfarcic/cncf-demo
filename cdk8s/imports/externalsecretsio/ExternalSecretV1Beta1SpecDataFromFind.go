package externalsecretsio


// Used to find secrets based on tags or regular expressions Note: Find does not support sourceRef.Generator or sourceRef.GeneratorRef.
type ExternalSecretV1Beta1SpecDataFromFind struct {
	// Used to define a conversion Strategy.
	ConversionStrategy *string `field:"optional" json:"conversionStrategy" yaml:"conversionStrategy"`
	// Used to define a decoding Strategy.
	DecodingStrategy *string `field:"optional" json:"decodingStrategy" yaml:"decodingStrategy"`
	// Finds secrets based on the name.
	Name *ExternalSecretV1Beta1SpecDataFromFindName `field:"optional" json:"name" yaml:"name"`
	// A root path to start the find operations.
	Path *string `field:"optional" json:"path" yaml:"path"`
	// Find secrets based on tags.
	Tags *map[string]*string `field:"optional" json:"tags" yaml:"tags"`
}

