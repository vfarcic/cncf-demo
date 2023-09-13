package externalsecretsio


// SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.
type ExternalSecretV1Beta1SpecSecretStoreRef struct {
	// Name of the SecretStore resource.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Kind of the SecretStore resource (SecretStore or ClusterSecretStore) Defaults to `SecretStore`.
	// Default: SecretStore`.
	//
	Kind *string `field:"optional" json:"kind" yaml:"kind"`
}

