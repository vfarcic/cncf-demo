//go:build no_runtime_type_checking

// databasesschemaheroio
package databasesschemaheroio

// Building without runtime type checking enabled, so all the below just return nil

func validateDatabase_IsConstructParameters(x interface{}) error {
	return nil
}

func validateDatabase_ManifestParameters(props *DatabaseProps) error {
	return nil
}

func validateDatabase_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewDatabaseParameters(scope constructs.Construct, id *string, props *DatabaseProps) error {
	return nil
}

