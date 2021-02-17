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

// SendNotFound json respons
func SendNotFound(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusBadRequest, message)
	c.AbortWithStatusJSON(http.StatusNotFound, message)
}

// SendForbidden json respons
func SendForbidden(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusBadRequest, message)
	c.AbortWithStatusJSON(http.StatusForbidden, message)
}

// SendUnauthorized json respons
func SendUnauthorized(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusBadRequest, message)
	c.AbortWithStatusJSON(http.StatusUnauthorized, message)
}

// SendInternalServerError json respons
func SendInternalServerError(c *gin.Context, message *gin.H) {
	// c.JSON(http.StatusBadRequest, message)
	c.AbortWithStatusJSON(http.StatusInternalServerError, message)
}
