package externalsecretsio


type ExternalSecretSpecTargetTemplateTemplateFromConfigMap struct {
	Items *[]*ExternalSecretSpecTargetTemplateTemplateFromConfigMapItems `field:"required" json:"items" yaml:"items"`
	Name *string `field:"required" json:"name" yaml:"name"`
}

