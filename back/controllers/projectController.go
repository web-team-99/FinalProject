package controllers

import (
	"fmt"
	"strconv"
	"time"
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

// CreateProject , form-data , auth
func CreateProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	autherid := getIDfromContex(c, "userid")

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

	if project.Priod < 0 || project.Price < 0 {
		SendBadRequest(c, &gin.H{"message": "price or priod is negative"})
		return
	}

	imgPath, staticPath := newImagePath(c, models.ProjectPath)
	project.Image = staticPath
	project.ID = bson.NewObjectId()
	project.AuthorID = autherid
	project.CreatedAt, project.UpdatedAt = time.Now(), time.Now()
	project.State = models.State0

	err = db.C(models.ProjectC).Insert(project)
	if err != nil {
		fmt.Println(err)
		SendInternalServerError(c, &gin.H{"message": "Error in the project insertion"})
		return
	}

	saveImage(c, imgPath)

	SendOK(c, &gin.H{"project": &project})
}

// AssignProject , quary: offerid , auth
func AssignProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	offerid, err := getIDfromQuery(c, "offerid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	offer := models.Offer{}
	err = db.C(models.OfferC).FindId(offerid).One(&offer)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "offer not found"})
		return
	}

	if offer.AuthorID != userid {
		SendForbidden(c, &gin.H{"message": "permission denied"})
		return
	}

	project := models.Project{}
	err = db.C(models.ProjectC).FindId(offer.ProjectID).One(&project)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "project not found"})
		return
	}

	if project.State != models.State0 {
		SendForbidden(c, &gin.H{"message": "project has been assigned"})
		return
	}

	project.Assigned = true
	project.AcceptedOfferID = offer.ID
	project.State = models.State1
	project.FreelancerID = offer.FreelancerID
	err = db.C(models.ProjectC).UpdateId(project.ID, &project)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "Error in updating project"})
		return
	}

	SendOK(c, &gin.H{"message": "offer assigned"})
}

// DoProject , quary: offerid & score , auth
func DoProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	offerid, err := getIDfromQuery(c, "offerid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	scorestr, ok := c.GetQuery("score")
	if !ok {
		SendNotFound(c, &gin.H{"message": "score not found"})
		return
	}
	score, err := strconv.Atoi(scorestr)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "score must be a number"})
		return
	}

	offer := models.Offer{}
	err = db.C(models.OfferC).FindId(offerid).One(&offer)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "offer not found"})
		return
	}

	if offer.AuthorID != userid {
		SendForbidden(c, &gin.H{"message": "permission denied"})
		return
	}

	project := models.Project{}
	err = db.C(models.ProjectC).FindId(offer.ProjectID).One(&project)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "project not found"})
		return
	}

	if project.State != models.State1 {
		SendForbidden(c, &gin.H{"message": "project not assigned"})
		return
	}

	freelancer := models.User{}
	err = db.C(models.UserC).FindId(offer.FreelancerID).One(&freelancer)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "freelancer not found"})
		return
	}

	numOfProjects := freelancer.FreelaceNo
	totalScore := freelancer.Score
	newScore := totalScore*numOfProjects + uint16(score)
	numOfProjects++
	newScore /= numOfProjects

	freelancer.FreelaceNo = numOfProjects
	freelancer.Score = newScore

	project.State = models.State2

	err = db.C(models.ProjectC).UpdateId(project.ID, &project)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "Error in updating project"})
		return
	}
	err = db.C(models.UserC).UpdateId(freelancer.ID, &freelancer)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "Error in updating user"})
		return
	}

	SendOK(c, &gin.H{"message": "project done"})
}

// GetProject , quary: projectid ,
func GetProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	projectid, err := getIDfromQuery(c, "projectid")
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

	SendOK(c, &gin.H{"project": &project})
}

// GetAllProjects ,  ,
func GetAllProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(nil).Sort("-created_at").All(&projects)
	if err != nil {
		fmt.Println(err)
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUnassignedProjects , ,
func GetAllUnassignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"state": "unassigned"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllAssignedProjects , ,
func GetAllAssignedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"state": "assigned"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllDoneProjects , ,
func GetAllDoneProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"state": "done"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
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

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
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

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "state": "unassigned"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
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

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "state": "assigned"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserDoneProjects , quary: userid ,
func GetAllUserDoneProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_autherid": userid, "state": "done"}).Sort("-created_at").All(&projects)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

// GetAllUserAcceptedProjects , , auth
func GetAllUserAcceptedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	userid := getIDfromContex(c, "userid")

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(bson.M{"_freelancerid": userid, "assigned": true}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}
