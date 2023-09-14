//go:build no_runtime_type_checking

package externalsecretsio

// Building without runtime type checking enabled, so all the below just return nil

func validateExternalSecret_IsApiObjectParameters(o interface{}) error {
	return nil
}

func validateExternalSecret_IsConstructParameters(x interface{}) error {
	return nil
}

func validateExternalSecret_ManifestParameters(props *ExternalSecretProps) error {
	return nil
}

func validateExternalSecret_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewExternalSecretParameters(scope constructs.Construct, id *string, props *ExternalSecretProps) error {
	return nil
}

