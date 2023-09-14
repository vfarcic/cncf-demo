package externalsecretsio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// ExternalSecret is the Schema for the external-secrets API.
type ExternalSecretV1Beta1Props struct {
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
	// ExternalSecretSpec defines the desired state of ExternalSecret.
	Spec *ExternalSecretV1Beta1Spec `field:"optional" json:"spec" yaml:"spec"`
}

