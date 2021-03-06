package controllers

import (
	"fmt"
	"strings"
	"time"
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

// CreateComment , form-data , auth
func CreateComment(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	writerid := getIDfromContex(c, "userid")

	comment := models.Comment{}
	err := c.Bind(&comment)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	comment.Text = strings.TrimSpace(comment.Text)

	if len(comment.Text) <= 1 {
		SendBadRequest(c, &gin.H{"message": "comment is too short"})
		return
	}

	if len(comment.Text) > 100 {
		SendBadRequest(c, &gin.H{"message": "comment is too long"})
		return
	}

	projectid, err := getIDfromBody(c, "_projectid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	project := models.Project{}
	err = db.C(models.ProjectC).FindId(projectid).One(&project)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "project not found"})
		return
	}

	comment.ID = bson.NewObjectId()
	comment.AuthorID = project.AuthorID
	comment.ProjectID = projectid
	comment.WriterID = writerid
	comment.CreatedAt, comment.UpdatedAt = time.Now(), time.Now()

	err = db.C(models.CommentC).Insert(comment)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "Error in the comment insertion"})
		return
	}

	SendOK(c, &gin.H{"comment": &comment})
}

// GetProjectComments , quary: projectid ,
func GetProjectComments(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	projectid, err := getIDfromQuery(c, "projectid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	comments := []models.Comment{}
	err = db.C(models.CommentC).Find(bson.M{"_projectid": projectid}).Sort("-created_at").All(&comments)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"comments": &comments})
}

// DeleteProjectComment , quary: commentid , auth
func DeleteProjectComment(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	commentid, err := getIDfromQuery(c, "commentid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	comment := models.Comment{}
	err = db.C(models.CommentC).FindId(commentid).One(&comment)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "comment not found"})
		return
	}

	if comment.AuthorID != userid && comment.WriterID != userid {
		SendForbidden(c, &gin.H{"message": "permission denied"})
		return
	}

	err = db.C(models.CommentC).RemoveId(commentid)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "error in removing comment"})
		return
	}

	SendOK(c, &gin.H{"message": "comment deleted"})
}
