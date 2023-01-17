package schemasschemaheroio

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"schemasschemaheroio.Table",
		reflect.TypeOf((*Table)(nil)).Elem(),
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
			j := jsiiProxy_Table{}
			_jsii_.InitJsiiProxy(&j.Type__cdk8sApiObject)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableProps",
		reflect.TypeOf((*TableProps)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpec",
		reflect.TypeOf((*TableSpec)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchema",
		reflect.TypeOf((*TableSpecSchema)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCassandra",
		reflect.TypeOf((*TableSpecSchemaCassandra)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCassandraClusteringOrder",
		reflect.TypeOf((*TableSpecSchemaCassandraClusteringOrder)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCassandraColumns",
		reflect.TypeOf((*TableSpecSchemaCassandraColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCassandraProperties",
		reflect.TypeOf((*TableSpecSchemaCassandraProperties)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdb",
		reflect.TypeOf((*TableSpecSchemaCockroachdb)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbColumns",
		reflect.TypeOf((*TableSpecSchemaCockroachdbColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbColumnsAttributes",
		reflect.TypeOf((*TableSpecSchemaCockroachdbColumnsAttributes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbColumnsConstraints",
		reflect.TypeOf((*TableSpecSchemaCockroachdbColumnsConstraints)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbForeignKeys",
		reflect.TypeOf((*TableSpecSchemaCockroachdbForeignKeys)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbForeignKeysReferences",
		reflect.TypeOf((*TableSpecSchemaCockroachdbForeignKeysReferences)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaCockroachdbIndexes",
		reflect.TypeOf((*TableSpecSchemaCockroachdbIndexes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysql",
		reflect.TypeOf((*TableSpecSchemaMysql)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlColumns",
		reflect.TypeOf((*TableSpecSchemaMysqlColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlColumnsAttributes",
		reflect.TypeOf((*TableSpecSchemaMysqlColumnsAttributes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlColumnsConstraints",
		reflect.TypeOf((*TableSpecSchemaMysqlColumnsConstraints)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlForeignKeys",
		reflect.TypeOf((*TableSpecSchemaMysqlForeignKeys)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlForeignKeysReferences",
		reflect.TypeOf((*TableSpecSchemaMysqlForeignKeysReferences)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaMysqlIndexes",
		reflect.TypeOf((*TableSpecSchemaMysqlIndexes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgres",
		reflect.TypeOf((*TableSpecSchemaPostgres)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresColumns",
		reflect.TypeOf((*TableSpecSchemaPostgresColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresColumnsAttributes",
		reflect.TypeOf((*TableSpecSchemaPostgresColumnsAttributes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresColumnsConstraints",
		reflect.TypeOf((*TableSpecSchemaPostgresColumnsConstraints)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresForeignKeys",
		reflect.TypeOf((*TableSpecSchemaPostgresForeignKeys)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresForeignKeysReferences",
		reflect.TypeOf((*TableSpecSchemaPostgresForeignKeysReferences)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaPostgresIndexes",
		reflect.TypeOf((*TableSpecSchemaPostgresIndexes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqlite",
		reflect.TypeOf((*TableSpecSchemaSqlite)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteColumns",
		reflect.TypeOf((*TableSpecSchemaSqliteColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteColumnsAttributes",
		reflect.TypeOf((*TableSpecSchemaSqliteColumnsAttributes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteColumnsConstraints",
		reflect.TypeOf((*TableSpecSchemaSqliteColumnsConstraints)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteForeignKeys",
		reflect.TypeOf((*TableSpecSchemaSqliteForeignKeys)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteForeignKeysReferences",
		reflect.TypeOf((*TableSpecSchemaSqliteForeignKeysReferences)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSchemaSqliteIndexes",
		reflect.TypeOf((*TableSpecSchemaSqliteIndexes)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSeedData",
		reflect.TypeOf((*TableSpecSeedData)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSeedDataRows",
		reflect.TypeOf((*TableSpecSeedDataRows)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSeedDataRowsColumns",
		reflect.TypeOf((*TableSpecSeedDataRowsColumns)(nil)).Elem(),
	)
	_jsii_.RegisterStruct(
		"schemasschemaheroio.TableSpecSeedDataRowsColumnsValue",
		reflect.TypeOf((*TableSpecSeedDataRowsColumnsValue)(nil)).Elem(),
	)
}
