package routes

import (
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func userRoutes(router *gin.RouterGroup) {
	user := router.Group("/user")
	{
		user.Use(middlewares.IsLoggedIn)

		user.GET("/", test)
		// user.GET("/jobs", test)
	}

	guest := router.Group("/guest")
	{
		guest.GET("/:userid", test)
		// guest.GET("/jobs/:userid", test)

	}
}
