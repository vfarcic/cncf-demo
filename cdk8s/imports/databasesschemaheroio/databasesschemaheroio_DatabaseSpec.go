// databasesschemaheroio
package databasesschemaheroio


type DatabaseSpec struct {
	// DatabaseConnection defines connection parameters for the database driver.
	Connection *DatabaseSpecConnection `field:"optional" json:"connection" yaml:"connection"`
	DeploySeedData *bool `field:"optional" json:"deploySeedData" yaml:"deploySeedData"`
	EnableShellCommand *bool `field:"optional" json:"enableShellCommand" yaml:"enableShellCommand"`
	ImmediateDeploy *bool `field:"optional" json:"immediateDeploy" yaml:"immediateDeploy"`
	Schemahero *DatabaseSpecSchemahero `field:"optional" json:"schemahero" yaml:"schemahero"`
	Template *DatabaseSpecTemplate `field:"optional" json:"template" yaml:"template"`
}

