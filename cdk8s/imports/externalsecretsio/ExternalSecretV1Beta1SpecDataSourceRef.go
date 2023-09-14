package externalsecretsio


// SourceRef allows you to override the source from which the value will pulled from.
type ExternalSecretV1Beta1SpecDataSourceRef struct {
	// GeneratorRef points to a generator custom resource in.
	GeneratorRef *ExternalSecretV1Beta1SpecDataSourceRefGeneratorRef `field:"optional" json:"generatorRef" yaml:"generatorRef"`
	// SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.
	StoreRef *ExternalSecretV1Beta1SpecDataSourceRefStoreRef `field:"optional" json:"storeRef" yaml:"storeRef"`
}

