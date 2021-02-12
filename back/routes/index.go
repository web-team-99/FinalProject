package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func indexRoutes(router *gin.RouterGroup) {
	path := router.Group("/")

	path.POST("/login", middlewares.IsEmailValid, middlewares.IsPassValid, controllers.Login)
	path.POST("/register", middlewares.IsEmailValid, middlewares.IsPassValid, controllers.Register)
	// path.GET("/projects"),
	// path.GET("/jobs", test)
}
