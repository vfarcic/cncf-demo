// devopstoolkitseriescom
package devopstoolkitseriescom

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

type SqlClaimProps struct {
	Spec *SqlClaimSpec `field:"required" json:"spec" yaml:"spec"`
	Metadata *cdk8s.ApiObjectMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

