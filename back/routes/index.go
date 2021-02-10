package routes

import (
	"github.com/gin-gonic/gin"
)

func indexRoutes(router *gin.RouterGroup) {
	path := router.Group("/")

	path.GET("/login", test)
	path.POST("/register", test)
	path.GET("/jobs", test)
}
