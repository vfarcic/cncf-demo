package externalsecretsio


// ExternalSecretData defines the connection between the Kubernetes Secret key (spec.data.<key>) and the Provider data.
type ExternalSecretV1Beta1SpecData struct {
	// RemoteRef points to the remote secret and defines which secret (version/property/..) to fetch.
	RemoteRef *ExternalSecretV1Beta1SpecDataRemoteRef `field:"required" json:"remoteRef" yaml:"remoteRef"`
	// SecretKey defines the key in which the controller stores the value.
	//
	// This is the key in the Kind=Secret.
	SecretKey *string `field:"required" json:"secretKey" yaml:"secretKey"`
	// SourceRef allows you to override the source from which the value will pulled from.
	SourceRef *ExternalSecretV1Beta1SpecDataSourceRef `field:"optional" json:"sourceRef" yaml:"sourceRef"`
}

