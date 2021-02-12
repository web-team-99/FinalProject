package controllers

import (
	"fmt"
	"time"
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

func CreateProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	project := models.Project{}
	err := c.Bind(&project)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	if len(project.Title) == 0 || len(project.ShortDescription) == 0 {
		SendBadRequest(c, &gin.H{"message": "title or description is empty"})
		return
	}

	project.ID = bson.NewObjectId()
	project.AuthorID = bson.NewObjectId() // to do
	project.CreatedAt, project.UpdatedAt = time.Now(), time.Now()

	err = db.C(models.ProjectC).Insert(project)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the project insertion"})
		return
	}
	SendOK(c, &gin.H{"project": &project})
}
