// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaCassandra struct {
	ClusteringOrder *TableSpecSchemaCassandraClusteringOrder `field:"optional" json:"clusteringOrder" yaml:"clusteringOrder"`
	Columns *[]*TableSpecSchemaCassandraColumns `field:"optional" json:"columns" yaml:"columns"`
	IsDeleted *bool `field:"optional" json:"isDeleted" yaml:"isDeleted"`
	PrimaryKey *[]*[]*string `field:"optional" json:"primaryKey" yaml:"primaryKey"`
	Properties *TableSpecSchemaCassandraProperties `field:"optional" json:"properties" yaml:"properties"`
}

