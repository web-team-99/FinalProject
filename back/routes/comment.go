package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func commentRoutes(router *gin.RouterGroup) {
	comment := router.Group("/comment")

	comment.POST("/", middlewares.IsLoggedIn, controllers.CreateComment)
	comment.GET("/", controllers.GetProjectComments)
	comment.DELETE("/", middlewares.IsLoggedIn, controllers.DeleteProjectComment)
}
