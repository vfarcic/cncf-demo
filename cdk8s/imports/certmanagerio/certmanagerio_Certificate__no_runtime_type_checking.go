//go:build no_runtime_type_checking

// cert-managerio
package certmanagerio

// Building without runtime type checking enabled, so all the below just return nil

func validateCertificate_IsConstructParameters(x interface{}) error {
	return nil
}

func validateCertificate_ManifestParameters(props *CertificateProps) error {
	return nil
}

func validateCertificate_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewCertificateParameters(scope constructs.Construct, id *string, props *CertificateProps) error {
	return nil
}

