package controllers

import (
	"webprj/models"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2"
)

func Login(c *gin.Context) {
	db := c.MustGet("db").(*mgo.Database)

	user := models.User{}
	err := c.Bind(&user)
	if err != nil {
		c.Error(err)
		return
	}

	err = db.C(models.UserC).Insert(user)
	if err != nil {
		c.Error(err)
	}
}
