package main

import (
	"fmt"

	shdb "example.com/cdk8s/imports/databasesschemaheroio"
	dot "example.com/cdk8s/imports/devopstoolkitseriescom"
	eso "example.com/cdk8s/imports/externalsecretsio"
	"example.com/cdk8s/imports/k8s"
	sht "example.com/cdk8s/imports/schemasschemaheroio"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

func getPostgresqlHelm(appProps *AppProps) *cdk8s.HelmProps {
	return &cdk8s.HelmProps{
		Chart:       jsii.String("bitnami/postgresql"),
		ReleaseName: jsii.String(fmt.Sprintf("%s-postgresql", appProps.Name)),
		Version:     jsii.String("12.1.2"),
		Namespace:   jsii.String("dev"),
		Values: &map[string]interface{}{
			"global": &map[string]interface{}{
				"persistence": &map[string]interface{}{
					"enabled": false,
				},
			},
			"auth": &map[string]interface{}{
				"postgresPassword": "postgres",
			},
			"primary": &map[string]interface{}{
				"initdb": &map[string]interface{}{
					"scripts": &map[string]interface{}{
						"00_init_script.sh": "export PGPASSWORD=$POSTGRES_PASSWORD\npsql -U postgres -c 'CREATE DATABASE \"cncf-demo\";'",
					},
				},
			},
		},
	}
}

func getPostgresqlCrossplane(appProps *AppProps, metadata *cdk8s.ApiObjectMetadata) *dot.SqlClaimProps {
	provider := "local-k8s"
	version := "11"
	size := appProps.Db.Size
	if appProps.Db.Enabled.Crossplane.Google {
		provider = "google"
	} else if appProps.Db.Enabled.Crossplane.AWS {
		provider = "aws"
	} else if appProps.Db.Enabled.Crossplane.Azure {
		provider = "azure"
	}
	if appProps.Db.Enabled.Crossplane.AWS {
		version = "16.5"
	}
	return &dot.SqlClaimProps{
		Metadata: metadata,
		Spec: &dot.SqlClaimSpec{
			Id: jsii.String(appProps.Db.Id),
			CompositionSelector: &dot.SqlClaimSpecCompositionSelector{
				MatchLabels: &map[string]*string{
					"provider": jsii.String(provider),
					"db":       jsii.String("postgresql"),
				},
			},
			Parameters: &dot.SqlClaimSpecParameters{
				Version: jsii.String(version),
				Size:    jsii.String(size),
			},
		},
	}
}

func getPostgresqlSecret(appProps *AppProps) *k8s.KubeSecretProps {
	metadata := &k8s.ObjectMeta{
		Name: jsii.String(fmt.Sprintf("%s-password", appProps.Db.Id)),
		Labels: &map[string]*string{
			"app.kubernetes.io/name": jsii.String(appProps.Name),
		},
	}
	return &k8s.KubeSecretProps{
		Metadata: metadata,
		Data: &map[string]*string{
			"password": jsii.String("T1QrOXZQcDhMdXhoeFVQWVpLSk1kUG1YM04xTzBTd3YzWG5ZVjI0UFZzcz0="),
		},
	}
}

func getPostgresqlExternalSecret(appProps *AppProps) *eso.ExternalSecretProps {
	metadata := &cdk8s.ApiObjectMetadata{
		Name: jsii.String(fmt.Sprintf("%s-password", appProps.Db.Id)),
		Labels: &map[string]*string{
			"app.kubernetes.io/name": jsii.String(appProps.Name),
		},
	}
	secretStoreRef := &eso.ExternalSecretSpecSecretStoreRef{
		Kind: jsii.String("ClusterSecretStore"),
	}
	if appProps.Db.Enabled.Crossplane.Google {
		secretStoreRef.Name = jsii.String("google")
	} else if appProps.Db.Enabled.Crossplane.Azure {
		secretStoreRef.Name = jsii.String("azure")
	} else if appProps.Db.Enabled.Crossplane.AWS {
		secretStoreRef.Name = jsii.String("aws")
	}
	spec := &eso.ExternalSecretSpec{
		RefreshInterval: jsii.String("1m"),
		SecretStoreRef:  secretStoreRef,
		Target: &eso.ExternalSecretSpecTarget{
			Name:           jsii.String(fmt.Sprintf("%s-password", appProps.Db.Id)),
			CreationPolicy: jsii.String("Owner"),
		},
		DataFrom: &[]*eso.ExternalSecretSpecDataFrom{
			{
				Key: jsii.String("production-postgresql"),
			},
		},
	}
	return &eso.ExternalSecretProps{
		Metadata: metadata,
		Spec:     spec,
	}
}

func getPostgresqlDatabase(appProps *AppProps, metadata *cdk8s.ApiObjectMetadata) *shdb.DatabaseProps {
	host := shdb.DatabaseSpecConnectionPostgresHost{}
	user := shdb.DatabaseSpecConnectionPostgresUser{}
	pass := shdb.DatabaseSpecConnectionPostgresPassword{
		ValueFrom: &shdb.DatabaseSpecConnectionPostgresPasswordValueFrom{
			SecretKeyRef: &shdb.DatabaseSpecConnectionPostgresPasswordValueFromSecretKeyRef{},
		},
	}
	port := shdb.DatabaseSpecConnectionPostgresPort{
		Value: jsii.String("5432"),
	}
	dbName := shdb.DatabaseSpecConnectionPostgresDbname{}
	if appProps.Db.Enabled.Helm {
		host.Value = jsii.String(appProps.Name + "-postgresql")
		user.Value = jsii.String("postgres")
		pass.ValueFrom.SecretKeyRef.Name = jsii.String(fmt.Sprintf("%s-postgresql", appProps.Name))
		pass.ValueFrom.SecretKeyRef.Key = jsii.String("postgres-password")
		dbName.Value = jsii.String(appProps.Name)
	} else if appProps.Db.Enabled.Crossplane.Local {
		host.Value = jsii.String(appProps.Db.Id + "-postgresql")
		user.Value = jsii.String("postgres")
		pass.ValueFrom.SecretKeyRef.Name = jsii.String(appProps.Db.Id + "-postgresql")
		pass.ValueFrom.SecretKeyRef.Key = jsii.String("postgres-password")
		dbName.Value = jsii.String(appProps.Name)
	} else if appProps.Db.Enabled.Crossplane.AWS {
		host.ValueFrom = &shdb.DatabaseSpecConnectionPostgresHostValueFrom{
			SecretKeyRef: &shdb.DatabaseSpecConnectionPostgresHostValueFromSecretKeyRef{
				Key:  jsii.String("endpoint"),
				Name: jsii.String(fmt.Sprintf("%s-password", appProps.Db.Id)),
			},
		}
		user.Value = jsii.String("masteruser")
		pass.ValueFrom.SecretKeyRef.Name = jsii.String(fmt.Sprintf("%s-password", appProps.Db.Id))
		pass.ValueFrom.SecretKeyRef.Key = jsii.String("password")
		dbName.Value = jsii.String(appProps.Db.Id)
	} else {
		host.ValueFrom = &shdb.DatabaseSpecConnectionPostgresHostValueFrom{
			SecretKeyRef: &shdb.DatabaseSpecConnectionPostgresHostValueFromSecretKeyRef{
				Key:  jsii.String("endpoint"),
				Name: jsii.String(appProps.Db.Id),
			},
		}
		user.ValueFrom = &shdb.DatabaseSpecConnectionPostgresUserValueFrom{
			SecretKeyRef: &shdb.DatabaseSpecConnectionPostgresUserValueFromSecretKeyRef{
				Key:  jsii.String("username"),
				Name: jsii.String(appProps.Db.Id),
			},
		}
		pass.ValueFrom.SecretKeyRef.Name = jsii.String(appProps.Db.Id)
		pass.ValueFrom.SecretKeyRef.Key = jsii.String("password")
		dbName.Value = jsii.String(appProps.Db.Id)
	}
	return &shdb.DatabaseProps{
		Metadata: metadata,
		Spec: &shdb.DatabaseSpec{
			ImmediateDeploy: jsii.Bool(true),
			Connection: &shdb.DatabaseSpecConnection{
				Postgres: &shdb.DatabaseSpecConnectionPostgres{
					Host:     &host,
					User:     &user,
					Password: &pass,
					Port:     &port,
					Dbname:   &dbName,
				},
			},
		},
	}
}

func getPostgresqlTable(appProps *AppProps, metadata *cdk8s.ApiObjectMetadata) *sht.TableProps {
	return &sht.TableProps{
		Metadata: metadata,
		Spec: &sht.TableSpec{
			Database: jsii.String(appProps.Name),
			Name:     jsii.String("videos"),
			Schema: &sht.TableSpecSchema{
				Postgres: &sht.TableSpecSchemaPostgres{
					PrimaryKey: &[]*string{jsii.String("id")},
					Columns: &[]*sht.TableSpecSchemaPostgresColumns{
						{
							Name: jsii.String("id"),
							Type: jsii.String("text"),
							Constraints: &sht.TableSpecSchemaPostgresColumnsConstraints{
								NotNull: jsii.Bool(true),
							},
						},
						{
							Name: jsii.String("title"),
							Type: jsii.String("text"),
							Constraints: &sht.TableSpecSchemaPostgresColumnsConstraints{
								NotNull: jsii.Bool(true),
							},
						},
					},
				},
			},
		},
	}
}

func setDbEnv(appProps *AppProps, container *k8s.Container) {
	if appProps.Db.Enabled.Helm || appProps.Db.Enabled.Crossplane.Local || appProps.Db.Enabled.Crossplane.Google || appProps.Db.Enabled.Crossplane.AWS || appProps.Db.Enabled.Crossplane.Azure {
		endPointEnv := k8s.EnvVar{
			Name: jsii.String("DB_ENDPOINT"),
		}
		portEnv := k8s.EnvVar{
			Name: jsii.String("DB_PORT"),
		}
		userEnv := k8s.EnvVar{
			Name: jsii.String("DB_USER"),
		}
		passEnv := k8s.EnvVar{
			Name: jsii.String("DB_PASS"),
		}
		nameEnv := k8s.EnvVar{
			Name:  jsii.String("DB_NAME"),
			Value: &appProps.Name,
		}
		if appProps.Db.Enabled.Crossplane.Local {
			endPointEnv.Value = jsii.String(appProps.Db.Id + "-postgresql")
			portEnv.Value = jsii.String("5432")
			userEnv.Value = jsii.String("postgres")
			passEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: jsii.String(appProps.Db.Id + "-postgresql"),
					Key:  jsii.String("postgres-password"),
				},
			}
		} else if appProps.Db.Enabled.Helm {
			endPointEnv.Value = jsii.String(appProps.Name + "-postgresql")
			portEnv.Value = jsii.String("5432")
			userEnv.Value = jsii.String("postgres")
			passEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: jsii.String(fmt.Sprintf("%s-postgresql", appProps.Name)),
					Key:  jsii.String("postgres-password"),
				},
			}
		} else {
			endPointEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: &appProps.Db.Id,
					Key:  jsii.String("endpoint"),
				},
			}
			portEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: &appProps.Db.Id,
					Key:  jsii.String("port"),
				},
			}
			userEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: &appProps.Db.Id,
					Key:  jsii.String("username"),
				},
			}
			passEnv.ValueFrom = &k8s.EnvVarSource{
				SecretKeyRef: &k8s.SecretKeySelector{
					Name: &appProps.Db.Id,
					Key:  jsii.String("password"),
				},
			}
			nameEnv.Value = &appProps.Db.Id
		}
		container.Env = &[]*k8s.EnvVar{
			&endPointEnv,
			&portEnv,
			&userEnv,
			&passEnv,
			&nameEnv,
		}
	}
}
