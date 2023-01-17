// cert-managerio
package certmanagerio


// Desired state of the Certificate resource.
type CertificateSpec struct {
	// IssuerRef is a reference to the issuer for this certificate.
	//
	// If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the Certificate will be used. If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times.
	IssuerRef *CertificateSpecIssuerRef `field:"required" json:"issuerRef" yaml:"issuerRef"`
	// SecretName is the name of the secret resource that will be automatically created and managed by this Certificate resource.
	//
	// It will be populated with a private key and certificate, signed by the denoted issuer.
	SecretName *string `field:"required" json:"secretName" yaml:"secretName"`
	// AdditionalOutputFormats defines extra output formats of the private key and signed certificate chain to be written to this Certificate's target Secret.
	//
	// This is an Alpha Feature and is only enabled with the `--feature-gates=AdditionalCertificateOutputFormats=true` option on both the controller and webhook components.
	AdditionalOutputFormats *[]*CertificateSpecAdditionalOutputFormats `field:"optional" json:"additionalOutputFormats" yaml:"additionalOutputFormats"`
	// CommonName is a common name to be used on the Certificate.
	//
	// The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs. This value is ignored by TLS clients when any subject alt name is set. This is x509 behaviour: https://tools.ietf.org/html/rfc6125#section-6.4.4
	CommonName *string `field:"optional" json:"commonName" yaml:"commonName"`
	// DNSNames is a list of DNS subjectAltNames to be set on the Certificate.
	DnsNames *[]*string `field:"optional" json:"dnsNames" yaml:"dnsNames"`
	// The requested 'duration' (i.e. lifetime) of the Certificate. This option may be ignored/overridden by some issuer types. If unset this defaults to 90 days. Certificate will be renewed either 2/3 through its duration or `renewBefore` period before its expiry, whichever is later. Minimum accepted duration is 1 hour. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration.
	Duration *string `field:"optional" json:"duration" yaml:"duration"`
	// EmailAddresses is a list of email subjectAltNames to be set on the Certificate.
	EmailAddresses *[]*string `field:"optional" json:"emailAddresses" yaml:"emailAddresses"`
	// EncodeUsagesInRequest controls whether key usages should be present in the CertificateRequest.
	EncodeUsagesInRequest *bool `field:"optional" json:"encodeUsagesInRequest" yaml:"encodeUsagesInRequest"`
	// IPAddresses is a list of IP address subjectAltNames to be set on the Certificate.
	IpAddresses *[]*string `field:"optional" json:"ipAddresses" yaml:"ipAddresses"`
	// IsCA will mark this Certificate as valid for certificate signing.
	//
	// This will automatically add the `cert sign` usage to the list of `usages`.
	IsCa *bool `field:"optional" json:"isCa" yaml:"isCa"`
	// Keystores configures additional keystore output formats stored in the `secretName` Secret resource.
	Keystores *CertificateSpecKeystores `field:"optional" json:"keystores" yaml:"keystores"`
	// LiteralSubject is an LDAP formatted string that represents the [X.509 Subject field](https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6). Use this *instead* of the Subject field if you need to ensure the correct ordering of the RDN sequence, such as when issuing certs for LDAP authentication. See https://github.com/cert-manager/cert-manager/issues/3203, https://github.com/cert-manager/cert-manager/issues/4424. This field is alpha level and is only supported by cert-manager installations where LiteralCertificateSubject feature gate is enabled on both cert-manager controller and webhook.
	LiteralSubject *string `field:"optional" json:"literalSubject" yaml:"literalSubject"`
	// Options to control private keys used for the Certificate.
	PrivateKey *CertificateSpecPrivateKey `field:"optional" json:"privateKey" yaml:"privateKey"`
	// How long before the currently issued certificate's expiry cert-manager should renew the certificate.
	//
	// The default is 2/3 of the issued certificate's duration. Minimum accepted value is 5 minutes. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration
	RenewBefore *string `field:"optional" json:"renewBefore" yaml:"renewBefore"`
	// revisionHistoryLimit is the maximum number of CertificateRequest revisions that are maintained in the Certificate's history.
	//
	// Each revision represents a single `CertificateRequest` created by this Certificate, either when it was created, renewed, or Spec was changed. Revisions will be removed by oldest first if the number of revisions exceeds this number. If set, revisionHistoryLimit must be a value of `1` or greater. If unset (`nil`), revisions will not be garbage collected. Default value is `nil`.
	RevisionHistoryLimit *float64 `field:"optional" json:"revisionHistoryLimit" yaml:"revisionHistoryLimit"`
	// SecretTemplate defines annotations and labels to be copied to the Certificate's Secret.
	//
	// Labels and annotations on the Secret will be changed as they appear on the SecretTemplate when added or removed. SecretTemplate annotations are added in conjunction with, and cannot overwrite, the base set of annotations cert-manager sets on the Certificate's Secret.
	SecretTemplate *CertificateSpecSecretTemplate `field:"optional" json:"secretTemplate" yaml:"secretTemplate"`
	// Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name).
	Subject *CertificateSpecSubject `field:"optional" json:"subject" yaml:"subject"`
	// URIs is a list of URI subjectAltNames to be set on the Certificate.
	Uris *[]*string `field:"optional" json:"uris" yaml:"uris"`
	// Usages is the set of x509 usages that are requested for the certificate.
	//
	// Defaults to `digital signature` and `key encipherment` if not specified.
	Usages *[]CertificateSpecUsages `field:"optional" json:"usages" yaml:"usages"`
}

