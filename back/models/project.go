package models

import (
	"time"

	"gopkg.in/mgo.v2/bson"
)

const (
	// ProjectC holds the name of the projects collection
	ProjectC    = "Project"
	ProjectPath = "/prj/"
	State0      = "unassigned"
	State1      = "assigned"
	State2      = "done"
)

type Project struct {
	ID               bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	AuthorID         bson.ObjectId `json:"_autherid,omitempty" bson:"_autherid,omitempty"`
	FreelancerID     bson.ObjectId `json:"_freelancerid,omitempty" bson:"_freelancerid,omitempty"`
	AcceptedOfferID  bson.ObjectId `json:"_offerid,omitempty" bson:"_offerid,omitempty"`
	Title            string        `json:"title" form:"title" binding:"required" bson:"title"`
	ShortDescription string        `json:"sdesc" form:"sdesc" binding:"required" bson:"sdesc"`
	Description      string        `json:"desc" form:"desc" bson:"desc"`
	Price            uint32        `json:"price" form:"price" bson:"price"`
	Priod            uint16        `json:"priod" form:"priod" bson:"priod"`
	Assigned         bool          //`json:"assigned" form:"assigned" bson:"assigned"`
	Image            string        //`json:"image,omitempty" form:"image,omitempty" bson:"image,omitempty"`
	State            string
	CreatedAt        time.Time `json:"created_at" bson:"created_at"`
	UpdatedAt        time.Time `json:"updated_at" bson:"updated_at"`
}
