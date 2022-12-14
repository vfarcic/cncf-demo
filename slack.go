package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/slack-go/slack"
	meta "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type Controller struct {
	ApiVersion      string `json:"apiVersion"`
	Kind            string `json:"kind"`
	meta.ObjectMeta `json:"metadata"`
}

type SyncRequest struct {
	Parent Controller `json:"parent"`
}

// Handle slack
func slackHandler(c *gin.Context) {
	body, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		println("JSON could not be retrieved")
		c.String(http.StatusBadRequest, "JSON could not be retrieved")
		return
	}
	request := &SyncRequest{}
	// Unmarshal the JSON into the struct.
	err = json.Unmarshal(body, request)
	if err != nil {
		println("JSON could not be unmarshalled")
		c.String(http.StatusBadRequest, "JSON could not be unmarshalled")
		return
	}
	managedField := request.Parent.ObjectMeta.ManagedFields[0]
	message := fmt.Sprintf(`API Version: %s
Kind: %s
Operation: %s`,
		request.Parent.ApiVersion,
		request.Parent.Kind,
		managedField.Operation)
	println(message)
	// Get channel parameter from query
	channel := c.Query("channel")
	// Throw error if channel is empty
	if channel == "" {
		channel = "#general"
	}
	// Get token from environment variable
	token := os.Getenv("SLACK_TOKEN")
	// Throw error if token is empty
	if token == "" {
		println("Environment variable `SLACK_TOKEN` is empty")
		c.String(http.StatusBadRequest, "Environment variable `SLACK_TOKEN` is empty")
		return
	}
	// Send message to Slack
	api := slack.New(token)
	_, _, err = api.PostMessage(channel, slack.MsgOptionText(message, false))
	// Throw error if message could not be sent
	if err != nil {
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	// Return success
	c.String(http.StatusOK, "Success")
}
