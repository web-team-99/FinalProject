package controllers

import (
	"webprj/models"

	"github.com/gin-gonic/gin"
)

func GetContactUs(c *gin.Context) {
	fields := []models.ContactUs{
		{"Email", "support@web.com"},
		{"Phone", "+98 22334455"},
		{"twitter", "twitter.com/web_programming"},
		{"instagram", "instagram.com/web_programming"},
		{"address", "tehran, azadi, sharif university of technology"},
	}
	SendOK(c, &gin.H{"fields": fields})
}
