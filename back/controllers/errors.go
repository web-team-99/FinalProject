package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// SendOK json respons
func SendOK(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusOK, message)
	c.AbortWithStatusJSON(http.StatusOK, message)
}

// SendBadRequest json respons
func SendBadRequest(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusBadRequest, message)
	c.AbortWithStatusJSON(http.StatusBadRequest, message)
}
