package devopstoolkitseriescom

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"devopstoolkitseriescom.SqlClaim",
		reflect.TypeOf((*SqlClaim)(nil)).Elem(),
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
			j := jsiiProxy_SqlClaim{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimProps",
		reflect.TypeOf((*SqlClaimProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpec",
		reflect.TypeOf((*SqlClaimSpec)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"devopstoolkitseriescom.SqlClaimSpecCompositeDeletePolicy",
		reflect.TypeOf((*SqlClaimSpecCompositeDeletePolicy)(nil)).Elem(),
		map[string]interface{}{
			"BACKGROUND": SqlClaimSpecCompositeDeletePolicy_BACKGROUND,
			"FOREGROUND": SqlClaimSpecCompositeDeletePolicy_FOREGROUND,
		},
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecCompositionRef",
		reflect.TypeOf((*SqlClaimSpecCompositionRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecCompositionRevisionRef",
		reflect.TypeOf((*SqlClaimSpecCompositionRevisionRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecCompositionSelector",
		reflect.TypeOf((*SqlClaimSpecCompositionSelector)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"devopstoolkitseriescom.SqlClaimSpecCompositionUpdatePolicy",
		reflect.TypeOf((*SqlClaimSpecCompositionUpdatePolicy)(nil)).Elem(),
		map[string]interface{}{
			"AUTOMATIC": SqlClaimSpecCompositionUpdatePolicy_AUTOMATIC,
			"MANUAL": SqlClaimSpecCompositionUpdatePolicy_MANUAL,
		},
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecParameters",
		reflect.TypeOf((*SqlClaimSpecParameters)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecPublishConnectionDetailsTo",
		reflect.TypeOf((*SqlClaimSpecPublishConnectionDetailsTo)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecPublishConnectionDetailsToConfigRef",
		reflect.TypeOf((*SqlClaimSpecPublishConnectionDetailsToConfigRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecPublishConnectionDetailsToMetadata",
		reflect.TypeOf((*SqlClaimSpecPublishConnectionDetailsToMetadata)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecResourceRef",
		reflect.TypeOf((*SqlClaimSpecResourceRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"devopstoolkitseriescom.SqlClaimSpecWriteConnectionSecretToRef",
		reflect.TypeOf((*SqlClaimSpecWriteConnectionSecretToRef)(nil)).Elem(),
	)
}
