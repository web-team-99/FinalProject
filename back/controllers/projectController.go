package controllers

import (
	"fmt"
	"time"
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

// CreateProject , form-data , auth
func CreateProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	autherIDstr := c.MustGet("userid").(string)

	imgPath := saveImage(c, models.ProjectPath)

	autherid := bson.ObjectIdHex(autherIDstr)

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
	project.AuthorID = autherid
	project.CreatedAt, project.UpdatedAt = time.Now(), time.Now()
	project.Image = imgPath

	err = db.C(models.ProjectC).Insert(project)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the project insertion"})
		return
	}
	SendOK(c, &gin.H{"project": &project})
}

// GetAllProjects ,  ,
func GetAllProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(nil).Sort("-created_at").All(&projects)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUnassignedProjects , ,
func GetAllUnassignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"assigned": false}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllAssignedProjects , ,
func GetAllAssignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"assigned": true}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserProjects , quary: userid ,
func GetAllUserProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(userid)

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserUnassignedProjects , quary: userid ,
func GetAllUserUnassignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(userid)

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "assigned": false}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserAssignedProjects , quary: userid ,
func GetAllUserAssignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(userid)

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "assigned": true}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserAcceptedProjects , , auth
func GetAllUserAcceptedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	userid := getIDfromContex(c, "userid")

	// userid, err := getIDfromQuery(c, "userid")
	// if err != nil {
	// 	SendBadRequest(c, &gin.H{"message": err.Error()})
	// 	return
	// }
	// fmt.Println(userid)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"_freelancerid": userid, "assigned": true}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// // GetAllProjectOffers , , auth
// func GetAllProjectOffers(c *gin.Context) {
// 	db := c.MustGet("db").(*mgo.Database)

// 	userid := getIDfromContex(c, "userid")

// 	// userid, err := getIDfromQuery(c, "userid")
// 	// if err != nil {
// 	// 	SendBadRequest(c, &gin.H{"message": err.Error()})
// 	// 	return
// 	// }
// 	// fmt.Println(userid)

// 	projects := []models.Project{}
// 	err := db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "assigned": true}).Sort("-created_at").All(&projects)
// 	if err != nil {
// 		SendBadRequest(c, &gin.H{"message": "empty"})
// 		return
// 	}

// 	SendOK(c, &gin.H{"projects": &projects})
// }
