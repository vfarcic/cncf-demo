package main

import (
	"errors"
	"log"
	"net/http"
	"os"

	"github.com/go-pg/pg/extra/pgotel/v10"
	"github.com/go-pg/pg/v10"

	"github.com/gin-gonic/gin"
)

var dbSession *pg.DB = nil

type Video struct {
	ID    string `json:"id"`
	Title string `json:"title"`
}

func videosGetHandler(ctx *gin.Context) {
	traceContext, span := tp.Tracer(serviceName).Start(ctx, "video-get")
	defer func() { span.End() }()

	span.AddEvent("Establishing connection to the database")
	db := getDB(ctx)
	if db == nil {
		return
	}
	var videos []Video
	err := db.ModelContext(traceContext, &videos).Select()
	if err != nil {
		httpErrorInternalServerError(err, span, ctx)
		return
	}
	ctx.JSON(http.StatusOK, videos)
}

func videoPostHandler(ctx *gin.Context) {
	traceContext, span := tp.Tracer(serviceName).Start(ctx, "video-post")
	defer func() { span.End() }()

	span.AddEvent("Establishing connection to the database...")
	db := getDB(ctx)
	if db == nil {
		return
	}
	span.AddEvent("Retrieving values...")
	id := ctx.Query("id")
	if len(id) == 0 {
		httpErrorBadRequest(errors.New("id is empty"), span, ctx)
		return
	}
	title := ctx.Query("title")
	if len(title) == 0 {
		httpErrorBadRequest(errors.New("title is empty"), span, ctx)
		return
	}
	span.AddEvent("Retrieving data from the database...")
	video := &Video{
		ID:    id,
		Title: title,
	}
	_, err := db.ModelContext(traceContext, video).Insert()
	if err != nil {
		httpErrorInternalServerError(err, span, ctx)
		return
	}
}

func getDB(c *gin.Context) *pg.DB {
	if dbSession != nil {
		return dbSession
	}
	endpoint := os.Getenv("DB_ENDPOINT")
	if len(endpoint) == 0 {
		log.Println("Environment variable `DB_ENDPOINT` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_ENDPOINT` is empty")
		return nil
	}
	port := os.Getenv("DB_PORT")
	if len(port) == 0 {
		log.Println("Environment variable `DB_PORT` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_PORT` is empty")
		return nil
	}
	user := os.Getenv("DB_USER")
	if len(user) == 0 {
		user = os.Getenv("DB_USERNAME")
		if len(user) == 0 {
			log.Println("Environment variables `DB_USER` and `DB_USERNAME` are empty")
			c.String(http.StatusBadRequest, "Environment variables `DB_USER` and `DB_USERNAME` are empty")
			return nil
		}
	}
	pass := os.Getenv("DB_PASS")
	if len(pass) == 0 {
		pass = os.Getenv("DB_PASSWORD")
		if len(pass) == 0 {
			log.Println("Environment variables `DB_PASS` and `DB_PASSWORD are empty")
			c.String(http.StatusBadRequest, "Environment variables `DB_PASS` and `DB_PASSWORD are empty")
			return nil
		}
	}
	name := os.Getenv("DB_NAME")
	if len(name) == 0 {
		log.Println("Environment variable `DB_NAME` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_NAME` is empty")
		return nil
	}
	dbSession := pg.Connect(&pg.Options{
		Addr:     endpoint + ":" + port,
		User:     user,
		Password: pass,
		Database: name,
	})
	dbSession.AddQueryHook(pgotel.NewTracingHook())
	return dbSession
}
