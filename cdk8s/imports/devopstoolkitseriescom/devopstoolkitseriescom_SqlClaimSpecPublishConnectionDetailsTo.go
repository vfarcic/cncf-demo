// devopstoolkitseriescom
package devopstoolkitseriescom


type SqlClaimSpecPublishConnectionDetailsTo struct {
	Name *string `field:"required" json:"name" yaml:"name"`
	ConfigRef *SqlClaimSpecPublishConnectionDetailsToConfigRef `field:"optional" json:"configRef" yaml:"configRef"`
	Metadata *SqlClaimSpecPublishConnectionDetailsToMetadata `field:"optional" json:"metadata" yaml:"metadata"`
}

