package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func projectRoutes(router *gin.RouterGroup) {
	path := router.Group("/project")

	path.POST("/new", middlewares.IsLoggedIn, controllers.CreateProject)
	path.POST("/offer", middlewares.IsLoggedIn, controllers.CreateOffer)
	path.GET("/assign", middlewares.IsLoggedIn, controllers.AssignProject)
}
