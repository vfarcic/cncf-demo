// cert-managerio
package certmanagerio


// Keystores configures additional keystore output formats stored in the `secretName` Secret resource.
type CertificateSpecKeystores struct {
	// JKS configures options for storing a JKS keystore in the `spec.secretName` Secret resource.
	Jks *CertificateSpecKeystoresJks `field:"optional" json:"jks" yaml:"jks"`
	// PKCS12 configures options for storing a PKCS12 keystore in the `spec.secretName` Secret resource.
	Pkcs12 *CertificateSpecKeystoresPkcs12 `field:"optional" json:"pkcs12" yaml:"pkcs12"`
}

