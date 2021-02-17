package controllers

import (
	"fmt"
	"time"
	"webprj/models"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
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

	result := models.User{}
	err = db.C(models.UserC).Find(bson.M{"email": user.Email}).One(&result)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "email not found"})
		return
	}

	if !checkPasswordHash(user.Password, result.Password) {
		SendForbidden(c, &gin.H{"message": "password is wrong"})
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

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	hashedPassword, err := hashPassword(user.Password)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "error in password hashing"})
		return
	}

	imgPath, staticPath := newImagePath(c, models.UserPath)
	user.Image = staticPath
	user.ID = bson.NewObjectId()
	user.CreatedAt, user.UpdatedAt = time.Now(), time.Now()
	user.Password = hashedPassword

	if !isEmailNew(db, user.ID, user.Email) {
		SendForbidden(c, &gin.H{"message": "email exist"})
		return
	}
	if !isPhoneNew(db, user.ID, user.Phone) {
		SendForbidden(c, &gin.H{"message": "phone exist"})
		return
	}

	err = db.C(models.UserC).Insert(user)
	if err != nil {
		SendInternalServerError(c, &gin.H{"message": "Error in the user insertion"})
		return
	}

	session := sessions.Default(c)
	session.Set("userid", user.ID.Hex())
	err = session.Save()
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err})
		return
	}

	saveImage(c, imgPath)
	user.Password = ""

	SendOK(c, &gin.H{"user": &user})
}

// UpdateUserInfo , form-data , auth
func UpdateUserInfo(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		SendBadRequest(c, &gin.H{"message": "Invalid request body"})
		return
	}

	if !isEmailNew(db, userid, user.Email) {
		SendForbidden(c, &gin.H{"message": "email exist"})
		return
	}
	if !isPhoneNew(db, userid, user.Phone) {
		SendForbidden(c, &gin.H{"message": "phone exist"})
		return
	}

	old := models.User{}
	err = db.C(models.UserC).FindId(userid).One(&old)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "user not found"})
		return
	}

	old.Name = user.Name
	old.LastName = user.LastName
	old.Email = user.Email
	old.Phone = user.Phone
	old.UpdatedAt = time.Now()

	err = db.C(models.UserC).UpdateId(userid, old)
	if err != nil {
		fmt.Println(err)
		SendInternalServerError(c, &gin.H{"message": "Error in updating user"})
		return
	}

	old.Password = ""

	SendOK(c, &gin.H{"user": &old})
}

// GetUserByID , quary: userid ,
func GetUserByID(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid, err := getIDfromQuery(c, "userid")
	if err != nil {
		SendBadRequest(c, &gin.H{"message": err.Error()})
		return
	}

	user := models.User{}
	err = db.C(models.UserC).FindId(userid).One(&user)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "user not found"})
		return
	}

	user.Password = ""
	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	SendOK(c, &gin.H{"user": &user})
}

// GetCurrentUser , , auth
func GetCurrentUser(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)
	userid := getIDfromContex(c, "userid")

	user := models.User{}
	err := db.C(models.UserC).FindId(userid).One(&user)
	if err != nil {
		SendNotFound(c, &gin.H{"message": "user not found"})
		return
	}

	user.Password = ""

	SendOK(c, &gin.H{"user": &user})
}

// GetAllUsers , ,
func GetAllUsers(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	users := []models.User{}
	err := db.C(models.UserC).Find(nil).Sort("-score").All(&users)
	if err != nil {
		fmt.Println(err)
		SendNotFound(c, &gin.H{"message": "empty"})
		return
	}

	for i := range users {
		users[i].Password = ""
		users[i].CreatedAt = time.Now()
		users[i].UpdatedAt = time.Now()
	}

	SendOK(c, &gin.H{"users": &users})
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
		fmt.Println(err)
		return false
	}
	return true
}

func hashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func checkPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
