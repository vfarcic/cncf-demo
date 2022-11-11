package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func rootHandler(c *gin.Context) {
	if len(c.Query("fail")) > 0 {
		c.String(http.StatusBadRequest, "Something terrible happened")
		return
	}
	version := os.Getenv("VERSION")
	output := os.Getenv("MESSAGE")
	if len(output) == 0 {
		output = "This is a silly demo"
	}
	if len(version) > 0 {
		output = fmt.Sprintf("%s version %s", output, version)
	}
	if len(c.Query("html")) > 0 {
		output = fmt.Sprintf("<h1>%s</h1>", output)
	}
	output = fmt.Sprintf("%s\n", output)
	c.String(http.StatusOK, output)
}
