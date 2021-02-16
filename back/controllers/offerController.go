package controllers

import (
	"fmt"
	"time"
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

// CreateOffer , form-data , auth
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
	// fmt.Println(time.Parse("2006-01-02 3:04PM", "1970-01-01 9:00PM"))
	offer.CreatedAt, offer.UpdatedAt = time.Now(), time.Now()

	err = db.C(models.OfferC).Insert(offer)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the offer insertion"})
		return
	}
	SendOK(c, &gin.H{"offer": &offer})
}

// AssignProject , quary: offerid , auth
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
	project.State = models.State1
	// project.Price = offer.Price
	project.FreelancerID = offer.FreelancerID
	db.C(models.ProjectC).UpdateId(project.ID, &project)

	SendOK(c, &gin.H{"message": "offer assigned"})
}

func DoneProject(c *gin.Context) {
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
	project.State = models.State2
	// project.Price = offer.Price
	project.FreelancerID = offer.FreelancerID
	db.C(models.ProjectC).UpdateId(project.ID, &project)

	SendOK(c, &gin.H{"message": "offer assigned"})
}

// GetProjectOffers , quary: projectid , auth
func GetProjectOffers(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	projectid, err := getIDfromQuery(c, "projectid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(projectid)

	offers := []models.Offer{}
	userQuary := []bson.M{{"_autherid": userid}, {"_freelancerid": userid}}
	err = db.C(models.OfferC).Find(bson.M{"$or": userQuary, "_projectid": projectid}).Sort("-created_at").All(&offers)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "empty"})
		return
	}

	SendOK(c, &gin.H{"offers": &offers})
}

// GetUserOffers , , auth
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

// GetFreelancerOffers , , auth
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
