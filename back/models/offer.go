package models

import (
	"time"

	"gopkg.in/mgo.v2/bson"
)

const (
	// OfferC holds the name of the offers collection
	OfferC = "Offer"
)

type Offer struct {
	ID           bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	AuthorID     bson.ObjectId `json:"_autherid,omitempty" bson:"_autherid,omitempty"`
	ProjectID    bson.ObjectId `json:"_projectid" bson:"_projectid"`
	FreelancerID bson.ObjectId `json:"_freelancerid,omitempty" bson:"_freelancerid,omitempty"`
	Price        int64         `json:"price" form:"price" binding:"required" bson:"price"`
	Description  string        `json:"desc" form:"desc" bson:"desc"`
	CreatedAt    time.Time     `json:"created_at" bson:"created_at"`
	UpdatedAt    time.Time     `json:"updated_at" bson:"updated_at"`
}
