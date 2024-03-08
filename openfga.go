package main

import (
	"context"
	"fmt"
	"log"
	"os"

	. "github.com/openfga/go-sdk/client"
)

func fgaCheck(user, relation string) (bool, error) {
	fgaUrl := os.Getenv("FGA_API_URL")
	if len(fgaUrl) == 0 {
		return true, nil
	}
	client, err := getFgaClient(fgaUrl)
	if err != nil {
		return false, err
	}
	body := ClientCheckRequest{
		User:     "user:" + user,
		Relation: relation,
		Object:   "document:silly-demo",
	}
	data, err := client.Check(context.Background()).Body(body).Execute()
	if err != nil {
		return false, err
	}
	return *data.Allowed, nil
}

func getFgaClient(url string) (*OpenFgaClient, error) {
	log.Println("Creating client...")
	storeID := os.Getenv("FGA_STORE_ID")
	if len(storeID) == 0 {
		return nil, fmt.Errorf("FGA_STORE_ID env. var. is missing")
	}
	modelID := os.Getenv("FGA_MODEL_ID")
	if len(modelID) == 0 {
		return nil, fmt.Errorf("FGA_MODEL_ID env. var. is missing")
	}
	client, err := NewSdkClient(&ClientConfiguration{
		ApiUrl:               url,
		StoreId:              storeID,
		AuthorizationModelId: modelID,
	})
	if err != nil {
		log.Fatal(err.Error())
	}
	return client, nil
}
