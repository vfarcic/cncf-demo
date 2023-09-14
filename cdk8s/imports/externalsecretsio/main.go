// external-secretsio
package externalsecretsio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"external-secretsio.ExternalSecret",
		reflect.TypeOf((*ExternalSecret)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberMethod{JsiiMethod: "addDependency", GoMethod: "AddDependency"},
			_jsii_.MemberMethod{JsiiMethod: "addJsonPatch", GoMethod: "AddJsonPatch"},
			_jsii_.MemberProperty{JsiiProperty: "apiGroup", GoGetter: "ApiGroup"},
			_jsii_.MemberProperty{JsiiProperty: "apiVersion", GoGetter: "ApiVersion"},
			_jsii_.MemberProperty{JsiiProperty: "chart", GoGetter: "Chart"},
			_jsii_.MemberProperty{JsiiProperty: "kind", GoGetter: "Kind"},
			_jsii_.MemberProperty{JsiiProperty: "metadata", GoGetter: "Metadata"},
			_jsii_.MemberProperty{JsiiProperty: "name", GoGetter: "Name"},
			_jsii_.MemberProperty{JsiiProperty: "node", GoGetter: "Node"},
			_jsii_.MemberMethod{JsiiMethod: "toJson", GoMethod: "ToJson"},
			_jsii_.MemberMethod{JsiiMethod: "toString", GoMethod: "ToString"},
		},
		func() interface{} {
			j := jsiiProxy_ExternalSecret{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretProps",
		reflect.TypeOf((*ExternalSecretProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpec",
		reflect.TypeOf((*ExternalSecretSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecData",
		reflect.TypeOf((*ExternalSecretSpecData)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecDataFrom",
		reflect.TypeOf((*ExternalSecretSpecDataFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecDataRemoteRef",
		reflect.TypeOf((*ExternalSecretSpecDataRemoteRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecSecretStoreRef",
		reflect.TypeOf((*ExternalSecretSpecSecretStoreRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTarget",
		reflect.TypeOf((*ExternalSecretSpecTarget)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplate",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplate)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateMetadata",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateTemplateFrom",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateTemplateFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateTemplateFromConfigMap",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateTemplateFromConfigMap)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateTemplateFromConfigMapItems",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateTemplateFromConfigMapItems)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateTemplateFromSecret",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateTemplateFromSecret)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretSpecTargetTemplateTemplateFromSecretItems",
		reflect.TypeOf((*ExternalSecretSpecTargetTemplateTemplateFromSecretItems)(nil)).Elem(),
	)
	_jsii_.RegisterClass(
		"external-secretsio.ExternalSecretV1Beta1",
		reflect.TypeOf((*ExternalSecretV1Beta1)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberMethod{JsiiMethod: "addDependency", GoMethod: "AddDependency"},
			_jsii_.MemberMethod{JsiiMethod: "addJsonPatch", GoMethod: "AddJsonPatch"},
			_jsii_.MemberProperty{JsiiProperty: "apiGroup", GoGetter: "ApiGroup"},
			_jsii_.MemberProperty{JsiiProperty: "apiVersion", GoGetter: "ApiVersion"},
			_jsii_.MemberProperty{JsiiProperty: "chart", GoGetter: "Chart"},
			_jsii_.MemberProperty{JsiiProperty: "kind", GoGetter: "Kind"},
			_jsii_.MemberProperty{JsiiProperty: "metadata", GoGetter: "Metadata"},
			_jsii_.MemberProperty{JsiiProperty: "name", GoGetter: "Name"},
			_jsii_.MemberProperty{JsiiProperty: "node", GoGetter: "Node"},
			_jsii_.MemberMethod{JsiiMethod: "toJson", GoMethod: "ToJson"},
			_jsii_.MemberMethod{JsiiMethod: "toString", GoMethod: "ToString"},
		},
		func() interface{} {
			j := jsiiProxy_ExternalSecretV1Beta1{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1Props",
		reflect.TypeOf((*ExternalSecretV1Beta1Props)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1Spec",
		reflect.TypeOf((*ExternalSecretV1Beta1Spec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecData",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecData)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFrom",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromExtract",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromExtract)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromFind",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromFind)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromFindName",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromFindName)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromRewrite",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromRewrite)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromRewriteRegexp",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromRewriteRegexp)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromSourceRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromSourceRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromSourceRefGeneratorRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromSourceRefGeneratorRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataFromSourceRefStoreRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataFromSourceRefStoreRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataRemoteRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataRemoteRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataSourceRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataSourceRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataSourceRefGeneratorRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataSourceRefGeneratorRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecDataSourceRefStoreRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecDataSourceRefStoreRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecSecretStoreRef",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecSecretStoreRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTarget",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTarget)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetCreationPolicy",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetCreationPolicy)(nil)).Elem(),
		map[string]interface{}{
			"OWNER": ExternalSecretV1Beta1SpecTargetCreationPolicy_OWNER,
			"ORPHAN": ExternalSecretV1Beta1SpecTargetCreationPolicy_ORPHAN,
			"MERGE": ExternalSecretV1Beta1SpecTargetCreationPolicy_MERGE,
			"NONE": ExternalSecretV1Beta1SpecTargetCreationPolicy_NONE,
		},
	)
	_jsii_.RegisterEnum(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetDeletionPolicy",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetDeletionPolicy)(nil)).Elem(),
		map[string]interface{}{
			"DELETE": ExternalSecretV1Beta1SpecTargetDeletionPolicy_DELETE,
			"MERGE": ExternalSecretV1Beta1SpecTargetDeletionPolicy_MERGE,
			"RETAIN": ExternalSecretV1Beta1SpecTargetDeletionPolicy_RETAIN,
		},
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplate",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplate)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateMetadata",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateTemplateFrom",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateTemplateFrom)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMap",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMap)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMapItems",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromConfigMapItems)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecret",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecret)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"external-secretsio.ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecretItems",
		reflect.TypeOf((*ExternalSecretV1Beta1SpecTargetTemplateTemplateFromSecretItems)(nil)).Elem(),
	)
}
