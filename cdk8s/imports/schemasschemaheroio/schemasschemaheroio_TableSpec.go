// schemasschemaheroio
package schemasschemaheroio


// TableSpec defines the desired state of Table.
type TableSpec struct {
	Database *string `field:"required" json:"database" yaml:"database"`
	Name *string `field:"required" json:"name" yaml:"name"`
	Requires *[]*string `field:"optional" json:"requires" yaml:"requires"`
	Schema *TableSpecSchema `field:"optional" json:"schema" yaml:"schema"`
	SeedData *TableSpecSeedData `field:"optional" json:"seedData" yaml:"seedData"`
}

