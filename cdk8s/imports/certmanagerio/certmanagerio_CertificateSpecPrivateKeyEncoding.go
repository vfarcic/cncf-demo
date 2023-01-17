// cert-managerio
package certmanagerio


// The private key cryptography standards (PKCS) encoding for this certificate's private key to be encoded in.
//
// If provided, allowed values are `PKCS1` and `PKCS8` standing for PKCS#1 and PKCS#8, respectively. Defaults to `PKCS1` if not specified.
type CertificateSpecPrivateKeyEncoding string

const (
	// PKCS1.
	CertificateSpecPrivateKeyEncoding_PKCS1 CertificateSpecPrivateKeyEncoding = "PKCS1"
	// PKCS8.
	CertificateSpecPrivateKeyEncoding_PKCS8 CertificateSpecPrivateKeyEncoding = "PKCS8"
)

