package externalsecretsio


// Used to rewrite with regular expressions.
//
// The resulting key will be the output of a regexp.ReplaceAll operation.
type ExternalSecretV1Beta1SpecDataFromRewriteRegexp struct {
	// Used to define the regular expression of a re.Compiler.
	Source *string `field:"required" json:"source" yaml:"source"`
	// Used to define the target pattern of a ReplaceAll operation.
	Target *string `field:"required" json:"target" yaml:"target"`
}

