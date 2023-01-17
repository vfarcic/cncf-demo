// schemasschemaheroio
package schemasschemaheroio


type TableSpecSchemaCassandraProperties struct {
	BloomFilterFpChance *string `field:"optional" json:"bloomFilterFpChance" yaml:"bloomFilterFpChance"`
	Caching *map[string]*string `field:"optional" json:"caching" yaml:"caching"`
	Comment *string `field:"optional" json:"comment" yaml:"comment"`
	Compaction *map[string]*string `field:"optional" json:"compaction" yaml:"compaction"`
	Compression *map[string]*string `field:"optional" json:"compression" yaml:"compression"`
	CrcCheckChance *string `field:"optional" json:"crcCheckChance" yaml:"crcCheckChance"`
	DcLocalReadRepairChance *string `field:"optional" json:"dcLocalReadRepairChance" yaml:"dcLocalReadRepairChance"`
	DefaultTtl *float64 `field:"optional" json:"defaultTtl" yaml:"defaultTtl"`
	GcGraceSeconds *float64 `field:"optional" json:"gcGraceSeconds" yaml:"gcGraceSeconds"`
	MaxIndexInterval *float64 `field:"optional" json:"maxIndexInterval" yaml:"maxIndexInterval"`
	MemtableFlushPeriodMs *float64 `field:"optional" json:"memtableFlushPeriodMs" yaml:"memtableFlushPeriodMs"`
	MinIndexInterval *float64 `field:"optional" json:"minIndexInterval" yaml:"minIndexInterval"`
	ReadRepairChance *string `field:"optional" json:"readRepairChance" yaml:"readRepairChance"`
	SpeculativeRetry *string `field:"optional" json:"speculativeRetry" yaml:"speculativeRetry"`
}

