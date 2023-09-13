package externalsecretsio


// GeneratorRef points to a generator custom resource in.
type ExternalSecretV1Beta1SpecDataFromSourceRefGeneratorRef struct {
	// Specify the Kind of the resource, e.g. Password, ACRAccessToken etc.
	Kind *string `field:"required" json:"kind" yaml:"kind"`
	// Specify the name of the generator resource.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Specify the apiVersion of the generator resource.
	ApiVersion *string `field:"optional" json:"apiVersion" yaml:"apiVersion"`
}

