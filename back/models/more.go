package models

// "net/url"

const (

// OfferC holds the name of the offers collection
// OfferC = "Offer"
)

type ContactUs struct {
	Name    string
	Address string
}

type AboutUs struct {
	Question string
	Answer   string
}

type Rules struct {
	Title   string
	Content string
}
