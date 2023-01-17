// cert-managerio
package certmanagerio


// IssuerRef is a reference to the issuer for this certificate.
//
// If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the Certificate will be used. If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times.
type CertificateSpecIssuerRef struct {
	// Name of the resource being referred to.
	Name *string `field:"required" json:"name" yaml:"name"`
	// Group of the resource being referred to.
	Group *string `field:"optional" json:"group" yaml:"group"`
	// Kind of the resource being referred to.
	Kind *string `field:"optional" json:"kind" yaml:"kind"`
}

