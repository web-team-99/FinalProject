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
	autherIDstr := c.MustGet("userid").(string)

	fmt.Println(autherIDstr)
	autherid := bson.ObjectIdHex(autherIDstr)
	// fmt.Println(autherid2)

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

	err = db.C(models.ProjectC).Insert(project)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the project insertion"})
		return
	}
	SendOK(c, &gin.H{"project": &project})
}

func CreateOffer(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	freelancerid := getIDfromContex(c, "userid")

	offer := models.Offer{}
	err := c.Bind(&offer)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	if offer.Price <= 0 {
		SendBadRequest(c, &gin.H{"message": "price must be positive"})
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
		SendBadRequest(c, &gin.H{"message": "project not found"})
		return
	}

	offer.ID = bson.NewObjectId()
	offer.AuthorID = project.AuthorID
	offer.ProjectID = projectid
	offer.FreelancerID = freelancerid
	offer.CreatedAt, offer.UpdatedAt = time.Now(), time.Now()

	err = db.C(models.OfferC).Insert(offer)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the offer insertion"})
		return
	}
	SendOK(c, &gin.H{"offer": &offer})
}

func AssignProject(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	offerid, err := getIDfromQuery(c, "offerid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(offerid)

	offer := models.Offer{}
	err = db.C(models.OfferC).FindId(offerid).One(&offer)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "offer not found"})
		return
	}

	project := models.Project{}
	err = db.C(models.ProjectC).FindId(offer.ProjectID).One(&project)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "project not found"})
		return
	}

	project.Assigned = true
	project.Price = offer.Price
	project.FreelancerID = offer.FreelancerID
	db.C(models.ProjectC).UpdateId(project.ID, &project)

	SendOK(c, &gin.H{"message": "offer assigned"})
}

func GetAllProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	projects := []models.Project{}
	err := db.C(models.ProjectC).Find(nil).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

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

func GetAllUserAcceptedProjects(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(userid)

	projects := []models.Project{}
	err = db.C(models.ProjectC).Find(bson.M{"_freelancerid": userid, "assigned": true}).Sort("-created_at").All(&projects)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"projects": &projects})
}

func GetAllProjectOffers(c *gin.Context) {
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

func GetPostOffers(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	projectid, err := getIDfromQuery(c, "projectid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(projectid)

	offers := []models.Offer{}
	err = db.C(models.OfferC).Find(bson.M{"_autherid": userid, "_projectid": projectid}).Sort("-created_at").All(&offers)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"offers": &offers})
}

func GetUserOffers(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")

	offers := []models.Offer{}
	err := db.C(models.OfferC).Find(bson.M{"_autherid": userid}).Sort("-created_at").All(&offers)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"offers": &offers})
}

func GetFreelancerOffers(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")

	offers := []models.Offer{}
	err := db.C(models.OfferC).Find(bson.M{"_freelancerid": userid}).Sort("-created_at").All(&offers)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"offers": &offers})
}
