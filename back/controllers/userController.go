package controllers

import (
	"fmt"
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

	// fmt.Println(result.Password)
	// fmt.Println(user.Password)

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

	if !isEmailNew(db, user.ID, user.Email) {
		SendBadRequest(c, &gin.H{"message": "email exist"})
		return
	}
	if !isPhoneNew(db, user.ID, user.Phone) {
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

func UpdateUserInfo(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	// imgPath := saveImage(c, models.UserPath)
	userid := getIDfromContex(c, "userid")

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}
	// user.ID = bson.NewObjectId()
	user.UpdatedAt = time.Now()
	// user.Image = imgPath

	if !isEmailNew(db, userid, user.Email) {
		SendBadRequest(c, &gin.H{"message": "email exist"})
		return
	}
	if !isPhoneNew(db, userid, user.Phone) {
		SendBadRequest(c, &gin.H{"message": "phone exist"})
		return
	}

	old := models.User{}
	err = db.C(models.UserC).FindId(userid).One(&old)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "user not found"})
		return
	}

	user.Password = old.Password
	user.CreatedAt = old.CreatedAt

	err = db.C(models.UserC).UpdateId(userid, user)
	if err != nil {
		fmt.Println(err)
		SendBadRequest(c, &gin.H{"message": "Error in the user insertion"})
		return
	}

	user.Password = ""

	SendOK(c, &gin.H{"user": &user})
}

func isPhoneNew(db *mgo.Database, userid bson.ObjectId, phone string) bool {
	count, err := db.C(models.UserC).Find(bson.M{"phone": phone, "_id": bson.M{"$ne": userid}}).Count()
	if err != nil || count > 0 {
		return false
	}
	return true
}

func isEmailNew(db *mgo.Database, userid bson.ObjectId, email string) bool {
	count, err := db.C(models.UserC).Find(bson.M{"email": email, "_id": bson.M{"$ne": userid}}).Count()
	if err != nil || count > 0 {
		return false
	}
	return true
}

func GetUserByID(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	// projectid, err := getIDfromQuery(c, "projectid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}
	fmt.Println(userid)

	user := models.User{}
	err = db.C(models.UserC).FindId(userid).One(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "user not found"})
		return
	}

	user.Password = ""
	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	SendOK(c, &gin.H{"user": &user})
}

func GetUser(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")
	// projectid, err := getIDfromQuery(c, "projectid")
	// if err != nil {
	// 	SendBadRequest(c, &gin.H{"message": err.Error()})
	// 	return
	// }
	fmt.Println(userid)

	user := models.User{}
	err := db.C(models.UserC).FindId(userid).One(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "user not found"})
		return
	}

	user.Password = ""
	// user.CreatedAt = time.Now()
	// user.UpdatedAt = time.Now()

	SendOK(c, &gin.H{"user": &user})
}
