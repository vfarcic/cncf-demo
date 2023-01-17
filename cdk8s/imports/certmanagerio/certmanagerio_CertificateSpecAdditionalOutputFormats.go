// cert-managerio
package certmanagerio


// CertificateAdditionalOutputFormat defines an additional output format of a Certificate resource.
//
// These contain supplementary data formats of the signed certificate chain and paired private key.
type CertificateSpecAdditionalOutputFormats struct {
	// Type is the name of the format type that should be written to the Certificate's target Secret.
	Type CertificateSpecAdditionalOutputFormatsType `field:"required" json:"type" yaml:"type"`
}

