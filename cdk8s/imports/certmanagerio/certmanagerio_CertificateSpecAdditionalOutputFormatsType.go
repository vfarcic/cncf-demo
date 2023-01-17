// cert-managerio
package certmanagerio


// Type is the name of the format type that should be written to the Certificate's target Secret.
type CertificateSpecAdditionalOutputFormatsType string

const (
	// DER.
	CertificateSpecAdditionalOutputFormatsType_DER CertificateSpecAdditionalOutputFormatsType = "DER"
	// CombinedPEM.
	CertificateSpecAdditionalOutputFormatsType_COMBINED_PEM CertificateSpecAdditionalOutputFormatsType = "COMBINED_PEM"
)

