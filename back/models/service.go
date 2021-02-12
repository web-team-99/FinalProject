package models

import (
	"time"

	"gopkg.in/mgo.v2/bson"
)

const (
	// ServiceC holds the name of the services collection
	ServiceC = "Service"
)

type Service struct {
	ID               bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	AuthorID         bson.ObjectId `json:"_autherid,omitempty" bson:"_autherid,omitempty"`
	Title            string        `json:"title" form:"title" binding:"required" bson:"title"`
	ShortDescription string        `json:"sdesc" form:"sdesc" binding:"required" bson:"sdesc"`
	Description      string        `json:"desc" form:"desc" bson:"desc"`
	Price            int64         `json:"price" form:"price" binding:"required" bson:"price"`
	CreatedAt        time.Time     `json:"created_at" bson:"created_at"`
	UpdatedAt        time.Time     `json:"updated_at" bson:"updated_at"`
}
