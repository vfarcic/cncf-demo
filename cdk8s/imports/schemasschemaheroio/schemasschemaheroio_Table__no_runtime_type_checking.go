//go:build no_runtime_type_checking

// schemasschemaheroio
package schemasschemaheroio

// Building without runtime type checking enabled, so all the below just return nil

func validateTable_IsConstructParameters(x interface{}) error {
	return nil
}

func validateTable_ManifestParameters(props *TableProps) error {
	return nil
}

func validateTable_OfParameters(c constructs.IConstruct) error {
	return nil
}

func validateNewTableParameters(scope constructs.Construct, id *string, props *TableProps) error {
	return nil
}

