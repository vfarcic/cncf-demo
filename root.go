package main

import (
	"fmt"
	"log/slog"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func rootHandler(ctx *gin.Context) {
	if len(ctx.Query("fail")) > 0 {
		ctx.String(http.StatusBadRequest, "Something terrible happened")
		return
	}
	slog.Debug("Handling request", "URI", ctx.Request.RequestURI)
	version := os.Getenv("VERSION")
	output := os.Getenv("MESSAGE")
	if len(output) == 0 {
		output = "This is a silly demo"
	}
	if len(version) > 0 {
		output = fmt.Sprintf("%s version %s", output, version)
	}
	if len(ctx.Query("html")) > 0 {
		output = fmt.Sprintf("<h1>%s</h1>", output)
	}
	output = fmt.Sprintf("%s\n", output)
	ctx.String(http.StatusOK, output)
}
