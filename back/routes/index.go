package routes

import (
	"webprj/controllers"

	"github.com/gin-gonic/gin"
)

func indexRoutes(router *gin.RouterGroup) {
	path := router.Group("/")

	path.POST("/login", controllers.Login)
	path.POST("/register", test)
	path.GET("/jobs", test)
}
