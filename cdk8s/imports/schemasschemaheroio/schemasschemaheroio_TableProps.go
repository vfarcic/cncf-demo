// schemasschemaheroio
package schemasschemaheroio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// Table is the Schema for the tables API.
type TableProps struct {
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
	// TableSpec defines the desired state of Table.
	Spec *TableSpec `field:"optional" json:"spec" yaml:"spec"`
}

