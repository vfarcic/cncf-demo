package externalsecretsio


type ExternalSecretSpecTargetTemplateTemplateFromSecret struct {
	Items *[]*ExternalSecretSpecTargetTemplateTemplateFromSecretItems `field:"required" json:"items" yaml:"items"`
	Name *string `field:"required" json:"name" yaml:"name"`
}

