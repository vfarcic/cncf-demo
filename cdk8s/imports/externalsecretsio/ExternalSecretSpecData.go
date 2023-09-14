package externalsecretsio


// ExternalSecretData defines the connection between the Kubernetes Secret key (spec.data.<key>) and the Provider data.
type ExternalSecretSpecData struct {
	// ExternalSecretDataRemoteRef defines Provider data location.
	RemoteRef *ExternalSecretSpecDataRemoteRef `field:"required" json:"remoteRef" yaml:"remoteRef"`
	SecretKey *string `field:"required" json:"secretKey" yaml:"secretKey"`
}

