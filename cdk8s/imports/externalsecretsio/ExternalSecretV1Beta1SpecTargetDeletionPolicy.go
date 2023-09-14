package externalsecretsio


// DeletionPolicy defines rules on how to delete the resulting Secret Defaults to 'Retain'.
// Default: Retain'.
//
type ExternalSecretV1Beta1SpecTargetDeletionPolicy string

const (
	// Delete.
	ExternalSecretV1Beta1SpecTargetDeletionPolicy_DELETE ExternalSecretV1Beta1SpecTargetDeletionPolicy = "DELETE"
	// Merge.
	ExternalSecretV1Beta1SpecTargetDeletionPolicy_MERGE ExternalSecretV1Beta1SpecTargetDeletionPolicy = "MERGE"
	// Retain.
	ExternalSecretV1Beta1SpecTargetDeletionPolicy_RETAIN ExternalSecretV1Beta1SpecTargetDeletionPolicy = "RETAIN"
)

