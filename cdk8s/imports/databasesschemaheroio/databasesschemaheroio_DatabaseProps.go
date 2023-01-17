// databasesschemaheroio
package databasesschemaheroio

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

// Database is the Schema for the databases API.
type DatabaseProps struct {
	Spec *DatabaseSpec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

