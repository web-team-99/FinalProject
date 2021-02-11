package models

import (
	"time"

	"gopkg.in/mgo.v2/bson"
)

const (
	// CollectionArticle holds the name of the articles collection
	UserC = "User"
)

type User struct {
	ID        bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	Name      string        `json:"name,omitempty" form:"name" bson:"name,omitempty"`
	LastName  string        `json:"lname,omitempty" form:"lname" bson:"lname,omitempty"`
	Password  string        `json:"password" form:"password" binding:"required" bson:"password"`
	Email     string        `json:"email" form:"email" binding:"required" bson:"email"`
	Phone     string        `json:"phone,omitempty" form:"phone" bson:"phone,omitempty"`
	CreatedAt time.Time     `json:"created_at" bson:"created_at"`
	UpdatedAt time.Time     `json:"updated_at" bson:"updated_at"`
}
