// cert-managerio
package certmanagerio


// RotationPolicy controls how private keys should be regenerated when a re-issuance is being processed.
//
// If set to Never, a private key will only be generated if one does not already exist in the target `spec.secretName`. If one does exists but it does not have the correct algorithm or size, a warning will be raised to await user intervention. If set to Always, a private key matching the specified requirements will be generated whenever a re-issuance occurs. Default is 'Never' for backward compatibility.
type CertificateSpecPrivateKeyRotationPolicy string

const (
	// Never.
	CertificateSpecPrivateKeyRotationPolicy_NEVER CertificateSpecPrivateKeyRotationPolicy = "NEVER"
	// Always.
	CertificateSpecPrivateKeyRotationPolicy_ALWAYS CertificateSpecPrivateKeyRotationPolicy = "ALWAYS"
)

