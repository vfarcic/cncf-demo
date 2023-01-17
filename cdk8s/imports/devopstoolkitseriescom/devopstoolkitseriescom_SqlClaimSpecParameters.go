// devopstoolkitseriescom
package devopstoolkitseriescom


type SqlClaimSpecParameters struct {
	// The DB version depends on the DB type and versions available in the selected provider.
	Version *string `field:"required" json:"version" yaml:"version"`
	// Supported sizes: small, medium, large.
	Size *string `field:"optional" json:"size" yaml:"size"`
}

