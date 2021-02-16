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
	ID        bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	AuthorID  bson.ObjectId `json:"_autherid,omitempty" bson:"_autherid,omitempty"`
	ProjectID bson.ObjectId `json:"_projectid" form:"_projectid" binding:"required" bson:"_projectid"`
	WriterID  bson.ObjectId `json:"_writerid,omitempty" bson:"_writerid,omitempty"`
	Text      string        `json:"text" form:"text" bson:"text"`
	CreatedAt time.Time     `json:"created_at" bson:"created_at"`
	UpdatedAt time.Time     `json:"updated_at" bson:"updated_at"`
}
