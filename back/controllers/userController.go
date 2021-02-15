package controllers

import (
	"time"
	"webprj/models"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

// Login controller
func Login(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	// results := []models.User{}
	result := models.User{}

	// err = db.C(models.UserC).Find(bson.M{"email": user.Email}).All(&results)
	err = db.C(models.UserC).Find(bson.M{"email": user.Email}).One(&result)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "email not found"})
		return
	}

	if result.Password != user.Password {
		SendBadRequest(c, &gin.H{"message": "password is wrong"})
		return
	}

	session := sessions.Default(c)
	session.Set("userid", result.ID.Hex())
	err = session.Save()
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err})
		return
	}

	result.Password = ""

	SendOK(c, &gin.H{"user": &result})
}

// Register  controller
func Register(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	imgPath := saveImage(c, models.UserPath)

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}
	user.ID = bson.NewObjectId()
	user.CreatedAt, user.UpdatedAt = time.Now(), time.Now()
	user.Image = imgPath

	if !isEmailNew(db, user.Email) {
		SendBadRequest(c, &gin.H{"message": "email exist"})
		return
	}
	if !isPhoneNew(db, user.Phone) {
		SendBadRequest(c, &gin.H{"message": "phone exist"})
		return
	}
	err = db.C(models.UserC).Insert(user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Error in the user insertion"})
		return
	}

	session := sessions.Default(c)
	session.Set("userid", user.ID.Hex())
	err = session.Save()
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err})
		return
	}

	user.Password = ""

	SendOK(c, &gin.H{"user": &user})
}

func isPhoneNew(db *mgo.Database, phone string) bool {
	count, err := db.C(models.UserC).Find(bson.M{"phone": phone}).Count()
	if err != nil || count > 0 {
		return false
	}
	return true
}

func isEmailNew(db *mgo.Database, email string) bool {
	count, err := db.C(models.UserC).Find(bson.M{"email": email}).Count()
	if err != nil || count > 0 {
		return false
	}
	return true
}
