package externalsecretsio


type ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecret struct {
	Items *[]*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecretItems `field:"required" json:"items" yaml:"items"`
	Name *string `field:"required" json:"name" yaml:"name"`
}

