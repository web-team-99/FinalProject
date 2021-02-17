package models

// "net/url"

const (

// OfferC holds the name of the offers collection
// OfferC = "Offer"
)

type ContactUs struct {
	Name    string `json:"name" form:"name" bson:"name"`
	Address string `json:"address" form:"address" bson:"address"`
}

type AboutUs struct {
	Name    string `json:"name" form:"name" bson:"name"`
	Address string `json:"url" form:"url" bson:"url"`
}
