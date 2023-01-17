// cert-managerio
package certmanagerio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// A Certificate resource should be created to ensure an up to date and signed x509 certificate is stored in the Kubernetes Secret resource named in `spec.secretName`. The stored certificate will be renewed before it expires (as configured by `spec.renewBefore`).
type CertificateProps struct {
	// Desired state of the Certificate resource.
	Spec *CertificateSpec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

