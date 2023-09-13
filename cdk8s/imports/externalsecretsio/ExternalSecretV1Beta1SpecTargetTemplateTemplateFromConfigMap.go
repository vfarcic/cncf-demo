package externalsecretsio


type ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMap struct {
	Items *[]*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMapItems `field:"required" json:"items" yaml:"items"`
	Name *string `field:"required" json:"name" yaml:"name"`
}

