package externalsecretsio


// Finds secrets based on the name.
type ExternalSecretV1Beta1SpecDataFromFindName struct {
	// Finds secrets base.
	Regexp *string `field:"optional" json:"regexp" yaml:"regexp"`
}

