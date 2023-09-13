package externalsecretsio


// CreationPolicy defines rules on how to create the resulting Secret Defaults to 'Owner'.
// Default: Owner'.
//
type ExternalSecretV1Beta1SpecTargetCreationPolicy string

const (
	// Owner.
	ExternalSecretV1Beta1SpecTargetCreationPolicy_OWNER ExternalSecretV1Beta1SpecTargetCreationPolicy = "OWNER"
	// Orphan.
	ExternalSecretV1Beta1SpecTargetCreationPolicy_ORPHAN ExternalSecretV1Beta1SpecTargetCreationPolicy = "ORPHAN"
	// Merge.
	ExternalSecretV1Beta1SpecTargetCreationPolicy_MERGE ExternalSecretV1Beta1SpecTargetCreationPolicy = "MERGE"
	// None.
	ExternalSecretV1Beta1SpecTargetCreationPolicy_NONE ExternalSecretV1Beta1SpecTargetCreationPolicy = "NONE"
)

