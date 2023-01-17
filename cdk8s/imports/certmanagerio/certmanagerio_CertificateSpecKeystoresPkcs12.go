// cert-managerio
package certmanagerio


// PKCS12 configures options for storing a PKCS12 keystore in the `spec.secretName` Secret resource.
type CertificateSpecKeystoresPkcs12 struct {
	// Create enables PKCS12 keystore creation for the Certificate.
	//
	// If true, a file named `keystore.p12` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. A file named `truststore.p12` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority
	Create *bool `field:"required" json:"create" yaml:"create"`
	// PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the PKCS12 keystore.
	PasswordSecretRef *CertificateSpecKeystoresPkcs12PasswordSecretRef `field:"required" json:"passwordSecretRef" yaml:"passwordSecretRef"`
}

