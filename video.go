package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"

	_ "github.com/lib/pq"

	"github.com/gin-gonic/gin"
)

var dbSession *sql.DB = nil

type Video struct {
	ID    string `json:"id"`
	Title string `json:"title"`
}

func videosGetHandler(c *gin.Context) {
	db := getDB(c)
	if db == nil {
		return
	}
	rows, err := db.Query("SELECT id, title FROM videos")
	if err != nil {
		fmt.Println(err)
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer rows.Close()
	var videos []Video
	for rows.Next() {
		var video Video
		err := rows.Scan(&video.ID, &video.Title)
		if err != nil {
			fmt.Println(err)
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		videos = append(videos, video)
	}
	c.JSON(http.StatusOK, videos)
}

func videoPostHandler(c *gin.Context) {
	db := getDB(c)
	if db == nil {
		return
	}
	// Get id from request
	id := c.Query("id")
	if len(id) == 0 {
		fmt.Println("id is empty")
		c.String(http.StatusBadRequest, "id is empty")
		return
	}
	// Get title from request
	title := c.Query("title")
	if len(title) == 0 {
		fmt.Println("title is empty")
		c.String(http.StatusBadRequest, "title is empty")
		return
	}
	// Insert data into the table videos
	_, err := db.Exec("INSERT INTO videos (id, title) VALUES ($1, $2)", id, title)
	if err != nil {
		fmt.Println(err)
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
}

func getDB(c *gin.Context) *sql.DB {
	if dbSession != nil {
		return dbSession
	}
	endpoint := os.Getenv("DB_ENDPOINT")
	if len(endpoint) == 0 {
		fmt.Println("Environment variable `DB_ENDPOINT` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_ENDPOINT` is empty")
		return nil
	}
	port := os.Getenv("DB_PORT")
	if len(port) == 0 {
		fmt.Println("Environment variable `DB_PORT` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_PORT` is empty")
		return nil
	}
	user := os.Getenv("DB_USER")
	if len(user) == 0 {
		user = os.Getenv("DB_USERNAME")
		if len(user) == 0 {
			fmt.Println("Environment variables `DB_USER` and `DB_USERNAME` are empty")
			c.String(http.StatusBadRequest, "Environment variables `DB_USER` and `DB_USERNAME` are empty")
			return nil
		}
	}
	pass := os.Getenv("DB_PASS")
	if len(pass) == 0 {
		pass = os.Getenv("DB_PASSWORD")
		if len(pass) == 0 {
			fmt.Println("Environment variables `DB_PASS` and `DB_PASSWORD are empty")
			c.String(http.StatusBadRequest, "Environment variables `DB_PASS` and `DB_PASSWORD are empty")
			return nil
		}
	}
	name := os.Getenv("DB_NAME")
	if len(name) == 0 {
		fmt.Println("Environment variable `DB_NAME` is empty")
		c.String(http.StatusBadRequest, "Environment variable `DB_NAME` is empty")
		return nil
	}
	psqlconn := fmt.Sprintf(
		"host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		endpoint,
		port,
		user,
		pass,
		name,
	)
	dbSession, err := sql.Open("postgres", psqlconn)
	if err != nil {
		fmt.Println(err)
		c.String(http.StatusInternalServerError, err.Error())
		return nil
	}
	return dbSession
}
