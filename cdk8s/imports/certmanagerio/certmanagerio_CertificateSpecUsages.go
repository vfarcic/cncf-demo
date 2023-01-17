// cert-managerio
package certmanagerio


// KeyUsage specifies valid usage contexts for keys.
//
// See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3 https://tools.ietf.org/html/rfc5280#section-4.2.1.12
// Valid KeyUsage values are as follows: "signing", "digital signature", "content commitment", "key encipherment", "key agreement", "data encipherment", "cert sign", "crl sign", "encipher only", "decipher only", "any", "server auth", "client auth", "code signing", "email protection", "s/mime", "ipsec end system", "ipsec tunnel", "ipsec user", "timestamping", "ocsp signing", "microsoft sgc", "netscape sgc".
type CertificateSpecUsages string

const (
	// signing.
	CertificateSpecUsages_SIGNING CertificateSpecUsages = "SIGNING"
	// digital signature.
	CertificateSpecUsages_DIGITAL_SIGNATURE CertificateSpecUsages = "DIGITAL_SIGNATURE"
	// content commitment.
	CertificateSpecUsages_CONTENT_COMMITMENT CertificateSpecUsages = "CONTENT_COMMITMENT"
	// key encipherment.
	CertificateSpecUsages_KEY_ENCIPHERMENT CertificateSpecUsages = "KEY_ENCIPHERMENT"
	// key agreement.
	CertificateSpecUsages_KEY_AGREEMENT CertificateSpecUsages = "KEY_AGREEMENT"
	// data encipherment.
	CertificateSpecUsages_DATA_ENCIPHERMENT CertificateSpecUsages = "DATA_ENCIPHERMENT"
	// cert sign.
	CertificateSpecUsages_CERT_SIGN CertificateSpecUsages = "CERT_SIGN"
	// crl sign.
	CertificateSpecUsages_CRL_SIGN CertificateSpecUsages = "CRL_SIGN"
	// encipher only.
	CertificateSpecUsages_ENCIPHER_ONLY CertificateSpecUsages = "ENCIPHER_ONLY"
	// decipher only.
	CertificateSpecUsages_DECIPHER_ONLY CertificateSpecUsages = "DECIPHER_ONLY"
	// any.
	CertificateSpecUsages_ANY CertificateSpecUsages = "ANY"
	// server auth.
	CertificateSpecUsages_SERVER_AUTH CertificateSpecUsages = "SERVER_AUTH"
	// client auth.
	CertificateSpecUsages_CLIENT_AUTH CertificateSpecUsages = "CLIENT_AUTH"
	// code signing.
	CertificateSpecUsages_CODE_SIGNING CertificateSpecUsages = "CODE_SIGNING"
	// email protection.
	CertificateSpecUsages_EMAIL_PROTECTION CertificateSpecUsages = "EMAIL_PROTECTION"
	// s/mime.
	CertificateSpecUsages_S_MIME CertificateSpecUsages = "S_MIME"
	// ipsec end system.
	CertificateSpecUsages_IPSEC_END_SYSTEM CertificateSpecUsages = "IPSEC_END_SYSTEM"
	// ipsec tunnel.
	CertificateSpecUsages_IPSEC_TUNNEL CertificateSpecUsages = "IPSEC_TUNNEL"
	// ipsec user.
	CertificateSpecUsages_IPSEC_USER CertificateSpecUsages = "IPSEC_USER"
	// timestamping.
	CertificateSpecUsages_TIMESTAMPING CertificateSpecUsages = "TIMESTAMPING"
	// ocsp signing.
	CertificateSpecUsages_OCSP_SIGNING CertificateSpecUsages = "OCSP_SIGNING"
	// microsoft sgc.
	CertificateSpecUsages_MICROSOFT_SGC CertificateSpecUsages = "MICROSOFT_SGC"
	// netscape sgc.
	CertificateSpecUsages_NETSCAPE_SGC CertificateSpecUsages = "NETSCAPE_SGC"
)

