// devopstoolkitseriescom
package devopstoolkitseriescom


type SqlClaimSpec struct {
	Parameters *SqlClaimSpecParameters `field:"required" json:"parameters" yaml:"parameters"`
	CompositeDeletePolicy SqlClaimSpecCompositeDeletePolicy `field:"optional" json:"compositeDeletePolicy" yaml:"compositeDeletePolicy"`
	CompositionRef *SqlClaimSpecCompositionRef `field:"optional" json:"compositionRef" yaml:"compositionRef"`
	CompositionRevisionRef *SqlClaimSpecCompositionRevisionRef `field:"optional" json:"compositionRevisionRef" yaml:"compositionRevisionRef"`
	CompositionSelector *SqlClaimSpecCompositionSelector `field:"optional" json:"compositionSelector" yaml:"compositionSelector"`
	CompositionUpdatePolicy SqlClaimSpecCompositionUpdatePolicy `field:"optional" json:"compositionUpdatePolicy" yaml:"compositionUpdatePolicy"`
	// Database ID.
	Id *string `field:"optional" json:"id" yaml:"id"`
	PublishConnectionDetailsTo *SqlClaimSpecPublishConnectionDetailsTo `field:"optional" json:"publishConnectionDetailsTo" yaml:"publishConnectionDetailsTo"`
	ResourceRef *SqlClaimSpecResourceRef `field:"optional" json:"resourceRef" yaml:"resourceRef"`
	WriteConnectionSecretToRef *SqlClaimSpecWriteConnectionSecretToRef `field:"optional" json:"writeConnectionSecretToRef" yaml:"writeConnectionSecretToRef"`
}

