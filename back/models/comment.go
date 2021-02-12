package models

import (
	"time"

	"gopkg.in/mgo.v2/bson"
)

const (
	// CommentC holds the name of the comments collection
	CommentC = "Comment"
)

type Comment struct {
	ID          bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	ServiceID   bson.ObjectId `json:"_serviceid,omitempty" bson:"_serviceid,omitempty"`
	WriterID    bson.ObjectId `json:"_writerid,omitempty" bson:"_writerid,omitempty"`
	Price       int64         `json:"price" form:"price" binding:"required" bson:"price"`
	Description string        `json:"desc" form:"desc" bson:"desc"`
	CreatedAt   time.Time     `json:"created_at" bson:"created_at"`
	UpdatedAt   time.Time     `json:"updated_at" bson:"updated_at"`
}
