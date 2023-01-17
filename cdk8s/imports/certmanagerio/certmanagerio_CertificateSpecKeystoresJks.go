// cert-managerio
package certmanagerio


// JKS configures options for storing a JKS keystore in the `spec.secretName` Secret resource.
type CertificateSpecKeystoresJks struct {
	// Create enables JKS keystore creation for the Certificate.
	//
	// If true, a file named `keystore.jks` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. A file named `truststore.jks` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority
	Create *bool `field:"required" json:"create" yaml:"create"`
	// PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the JKS keystore.
	PasswordSecretRef *CertificateSpecKeystoresJksPasswordSecretRef `field:"required" json:"passwordSecretRef" yaml:"passwordSecretRef"`
}

