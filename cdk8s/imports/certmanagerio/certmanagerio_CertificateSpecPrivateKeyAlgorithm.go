// cert-managerio
package certmanagerio


// Algorithm is the private key algorithm of the corresponding private key for this certificate.
//
// If provided, allowed values are either `RSA`,`Ed25519` or `ECDSA` If `algorithm` is specified and `size` is not provided, key size of 256 will be used for `ECDSA` key algorithm and key size of 2048 will be used for `RSA` key algorithm. key size is ignored when using the `Ed25519` key algorithm.
type CertificateSpecPrivateKeyAlgorithm string

const (
	// RSA.
	CertificateSpecPrivateKeyAlgorithm_RSA CertificateSpecPrivateKeyAlgorithm = "RSA"
	// ECDSA.
	CertificateSpecPrivateKeyAlgorithm_ECDSA CertificateSpecPrivateKeyAlgorithm = "ECDSA"
	// Ed25519.
	CertificateSpecPrivateKeyAlgorithm_ED25519 CertificateSpecPrivateKeyAlgorithm = "ED25519"
)

