package certmanagerio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"cert-managerio.Certificate",
		reflect.TypeOf((*Certificate)(nil)).Elem(),
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
			j := jsiiProxy_Certificate{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateProps",
		reflect.TypeOf((*CertificateProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpec",
		reflect.TypeOf((*CertificateSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecAdditionalOutputFormats",
		reflect.TypeOf((*CertificateSpecAdditionalOutputFormats)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"cert-managerio.CertificateSpecAdditionalOutputFormatsType",
		reflect.TypeOf((*CertificateSpecAdditionalOutputFormatsType)(nil)).Elem(),
		map[string]interface{}{
			"DER": CertificateSpecAdditionalOutputFormatsType_DER,
			"COMBINED_PEM": CertificateSpecAdditionalOutputFormatsType_COMBINED_PEM,
		},
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecIssuerRef",
		reflect.TypeOf((*CertificateSpecIssuerRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecKeystores",
		reflect.TypeOf((*CertificateSpecKeystores)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecKeystoresJks",
		reflect.TypeOf((*CertificateSpecKeystoresJks)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecKeystoresJksPasswordSecretRef",
		reflect.TypeOf((*CertificateSpecKeystoresJksPasswordSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecKeystoresPkcs12",
		reflect.TypeOf((*CertificateSpecKeystoresPkcs12)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecKeystoresPkcs12PasswordSecretRef",
		reflect.TypeOf((*CertificateSpecKeystoresPkcs12PasswordSecretRef)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecPrivateKey",
		reflect.TypeOf((*CertificateSpecPrivateKey)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"cert-managerio.CertificateSpecPrivateKeyAlgorithm",
		reflect.TypeOf((*CertificateSpecPrivateKeyAlgorithm)(nil)).Elem(),
		map[string]interface{}{
			"RSA": CertificateSpecPrivateKeyAlgorithm_RSA,
			"ECDSA": CertificateSpecPrivateKeyAlgorithm_ECDSA,
			"ED25519": CertificateSpecPrivateKeyAlgorithm_ED25519,
		},
	)
	_jsii_.RegisterEnum(
		"cert-managerio.CertificateSpecPrivateKeyEncoding",
		reflect.TypeOf((*CertificateSpecPrivateKeyEncoding)(nil)).Elem(),
		map[string]interface{}{
			"PKCS1": CertificateSpecPrivateKeyEncoding_PKCS1,
			"PKCS8": CertificateSpecPrivateKeyEncoding_PKCS8,
		},
	)
	_jsii_.RegisterEnum(
		"cert-managerio.CertificateSpecPrivateKeyRotationPolicy",
		reflect.TypeOf((*CertificateSpecPrivateKeyRotationPolicy)(nil)).Elem(),
		map[string]interface{}{
			"NEVER": CertificateSpecPrivateKeyRotationPolicy_NEVER,
			"ALWAYS": CertificateSpecPrivateKeyRotationPolicy_ALWAYS,
		},
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecSecretTemplate",
		reflect.TypeOf((*CertificateSpecSecretTemplate)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"cert-managerio.CertificateSpecSubject",
		reflect.TypeOf((*CertificateSpecSubject)(nil)).Elem(),
	)
	_jsii_.RegisterEnum(
		"cert-managerio.CertificateSpecUsages",
		reflect.TypeOf((*CertificateSpecUsages)(nil)).Elem(),
		map[string]interface{}{
			"SIGNING": CertificateSpecUsages_SIGNING,
			"DIGITAL_SIGNATURE": CertificateSpecUsages_DIGITAL_SIGNATURE,
			"CONTENT_COMMITMENT": CertificateSpecUsages_CONTENT_COMMITMENT,
			"KEY_ENCIPHERMENT": CertificateSpecUsages_KEY_ENCIPHERMENT,
			"KEY_AGREEMENT": CertificateSpecUsages_KEY_AGREEMENT,
			"DATA_ENCIPHERMENT": CertificateSpecUsages_DATA_ENCIPHERMENT,
			"CERT_SIGN": CertificateSpecUsages_CERT_SIGN,
			"CRL_SIGN": CertificateSpecUsages_CRL_SIGN,
			"ENCIPHER_ONLY": CertificateSpecUsages_ENCIPHER_ONLY,
			"DECIPHER_ONLY": CertificateSpecUsages_DECIPHER_ONLY,
			"ANY": CertificateSpecUsages_ANY,
			"SERVER_AUTH": CertificateSpecUsages_SERVER_AUTH,
			"CLIENT_AUTH": CertificateSpecUsages_CLIENT_AUTH,
			"CODE_SIGNING": CertificateSpecUsages_CODE_SIGNING,
			"EMAIL_PROTECTION": CertificateSpecUsages_EMAIL_PROTECTION,
			"S_MIME": CertificateSpecUsages_S_MIME,
			"IPSEC_END_SYSTEM": CertificateSpecUsages_IPSEC_END_SYSTEM,
			"IPSEC_TUNNEL": CertificateSpecUsages_IPSEC_TUNNEL,
			"IPSEC_USER": CertificateSpecUsages_IPSEC_USER,
			"TIMESTAMPING": CertificateSpecUsages_TIMESTAMPING,
			"OCSP_SIGNING": CertificateSpecUsages_OCSP_SIGNING,
			"MICROSOFT_SGC": CertificateSpecUsages_MICROSOFT_SGC,
			"NETSCAPE_SGC": CertificateSpecUsages_NETSCAPE_SGC,
		},
	)
}
