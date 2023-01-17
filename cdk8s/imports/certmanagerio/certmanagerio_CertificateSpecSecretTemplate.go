// cert-managerio
package certmanagerio


// SecretTemplate defines annotations and labels to be copied to the Certificate's Secret.
//
// Labels and annotations on the Secret will be changed as they appear on the SecretTemplate when added or removed. SecretTemplate annotations are added in conjunction with, and cannot overwrite, the base set of annotations cert-manager sets on the Certificate's Secret.
type CertificateSpecSecretTemplate struct {
	// Annotations is a key value map to be copied to the target Kubernetes Secret.
	Annotations *map[string]*string `field:"optional" json:"annotations" yaml:"annotations"`
	// Labels is a key value map to be copied to the target Kubernetes Secret.
	Labels *map[string]*string `field:"optional" json:"labels" yaml:"labels"`
}

