package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"go.opentelemetry.io/contrib/instrumentation/github.com/gin-gonic/gin/otelgin"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/codes"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/trace"
)

var serviceName string

func main() {
	log.SetOutput(os.Stderr)
	serviceName = "silly-demo"
	if os.Getenv("SERVICE_NAME") != "" {
		serviceName = os.Getenv("SERVICE_NAME")
	}

	// OpenTelemetry
	var err error
	tp, err = initTracer()
	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		if err := tp.Shutdown(context.Background()); err != nil {
			log.Printf("Error shutting down tracer provider: %v", err)
		}
	}()
	otel.SetTracerProvider(tp)
	otel.SetTextMapPropagator(propagation.NewCompositeTextMapPropagator(propagation.TraceContext{}, propagation.Baggage{}))

	// Server
	log.Println("Starting server...")
	router := gin.New()
	router.Use(otelgin.Middleware(serviceName))
	router.GET("/fibonacci", fibonacciHandler)
	router.POST("/slack", slackHandler)
	router.POST("/video", videoPostHandler)
	router.GET("/videos", videosGetHandler)
	router.GET("/ping", pingHandler)
	router.GET("/", rootHandler)
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}
	router.Run(fmt.Sprintf(":%s", port))
}

func httpErrorBadRequest(err error, span trace.Span, ctx *gin.Context) {
	httpError(err, span, ctx, http.StatusBadRequest)
}

func httpErrorInternalServerError(err error, span trace.Span, ctx *gin.Context) {
	httpError(err, span, ctx, http.StatusInternalServerError)
}

func httpError(err error, span trace.Span, ctx *gin.Context, status int) {
	log.Println(err.Error())
	span.RecordError(err)
	span.SetStatus(codes.Error, err.Error())
	ctx.String(status, err.Error())
}
