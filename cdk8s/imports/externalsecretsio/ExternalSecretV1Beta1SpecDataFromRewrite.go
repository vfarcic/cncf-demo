package externalsecretsio


type ExternalSecretV1Beta1SpecDataFromRewrite struct {
	// Used to rewrite with regular expressions.
	//
	// The resulting key will be the output of a regexp.ReplaceAll operation.
	Regexp *ExternalSecretV1Beta1SpecDataFromRewriteRegexp `field:"optional" json:"regexp" yaml:"regexp"`
}

