package controllers

import (
	"errors"
	"fmt"

	"github.com/gin-gonic/gin"
	"gopkg.in/mgo.v2/bson"
)

func getIDfromContex(c *gin.Context, key string) bson.ObjectId {
	idstr := c.MustGet(key).(string)
	id := bson.ObjectIdHex(idstr)
	return id
}

func getIDfromBody(c *gin.Context, key string) (bson.ObjectId, error) {
	defer func() {
		if err := recover(); err != nil {
			// return "", errors.New("invalid id")
			fmt.Println("errrrrrr")
		}
	}()

	idstr, ok := c.GetPostForm(key)
	if !ok {
		return "", errors.New("key not found")
	}
	// if len(idstr) != 12 {
	// 	return "", errors.New("invalid id")
	// }
	id := bson.ObjectIdHex(idstr)
	return id, nil
}

func getIDfromQuery(c *gin.Context, key string) (bson.ObjectId, error) {
	idstr, ok := c.GetQuery(key)
	if !ok {
		return "", errors.New("key not found")
	}
	id := bson.ObjectIdHex(idstr)
	return id, nil
}
