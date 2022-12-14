package main

import (
	"errors"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/go-resty/resty/v2"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/trace"
)

func pingHandler(ctx *gin.Context) {
	req := resty.New().R().SetHeader("Content-Type", "application/text")
	otelCtx := ctx.Request.Context()
	span := trace.SpanFromContext(otelCtx)
	defer span.End()
	otel.GetTextMapPropagator().Inject(otelCtx, propagation.HeaderCarrier(req.Header))
	url := ctx.Query("url")
	if len(url) == 0 {
		httpErrorBadRequest(errors.New("url is empty"), span, ctx)
		return
	}
	log.Printf("Sending a ping to %s", url)
	resp, _ := req.Get(url)
	log.Println(resp.String())
	ctx.String(http.StatusOK, resp.String())
}
