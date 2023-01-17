//go:build no_runtime_type_checking

// devopstoolkitseriescom
package devopstoolkitseriescom

// Building without runtime type checking enabled, so all the below just return nil

func validateSqlClaim_IsConstructParameters(x interface{}) error {
	return nil
}

func validateSqlClaim_ManifestParameters(props *SqlClaimProps) error {
	return nil
}

func validateSqlClaim_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewSqlClaimParameters(scope constructs.Construct, id *string, props *SqlClaimProps) error {
	return nil
}

