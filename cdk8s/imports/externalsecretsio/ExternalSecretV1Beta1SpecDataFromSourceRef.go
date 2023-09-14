package externalsecretsio


// SourceRef points to a store or generator which contains secret values ready to use.
//
// Use this in combination with Extract or Find pull values out of a specific SecretStore. When sourceRef points to a generator Extract or Find is not supported. The generator returns a static map of values
type ExternalSecretV1Beta1SpecDataFromSourceRef struct {
	// GeneratorRef points to a generator custom resource in.
	GeneratorRef *ExternalSecretV1Beta1SpecDataFromSourceRefGeneratorRef `field:"optional" json:"generatorRef" yaml:"generatorRef"`
	// SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.
	StoreRef *ExternalSecretV1Beta1SpecDataFromSourceRefStoreRef `field:"optional" json:"storeRef" yaml:"storeRef"`
}

