package externalsecretsio


// ExternalSecretSpec defines the desired state of ExternalSecret.
type ExternalSecretV1Beta1Spec struct {
	// Data defines the connection between the Kubernetes Secret keys and the Provider data.
	Data *[]*ExternalSecretV1Beta1SpecData `field:"optional" json:"data" yaml:"data"`
	// DataFrom is used to fetch all properties from a specific Provider data If multiple entries are specified, the Secret keys are merged in the specified order.
	DataFrom *[]*ExternalSecretV1Beta1SpecDataFrom `field:"optional" json:"dataFrom" yaml:"dataFrom"`
	// RefreshInterval is the amount of time before the values are read again from the SecretStore provider Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h" May be set to zero to fetch and create it once.
	//
	// Defaults to 1h.
	// Default: 1h.
	//
	RefreshInterval *string `field:"optional" json:"refreshInterval" yaml:"refreshInterval"`
	// SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.
	SecretStoreRef *ExternalSecretV1Beta1SpecSecretStoreRef `field:"optional" json:"secretStoreRef" yaml:"secretStoreRef"`
	// ExternalSecretTarget defines the Kubernetes Secret to be created There can be only one target per ExternalSecret.
	Target *ExternalSecretV1Beta1SpecTarget `field:"optional" json:"target" yaml:"target"`
}

