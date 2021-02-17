package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func userRoutes(router *gin.RouterGroup) {
	user := router.Group("/user")
	{
		// user.Use(middlewares.IsLoggedIn)

		user.PUT("/update", middlewares.IsLoggedIn, controllers.UpdateUserInfo)
		user.GET("/", middlewares.IsLoggedIn, controllers.GetUser)
		user.GET("/all", controllers.GetAllUsers)

		user.GET("/byid", controllers.GetUserByID)
		// user.GET("/jobs", test)
	}

	guest := router.Group("/guest")
	{
		guest.GET("/:userid", test)
		// guest.GET("/jobs/:userid", test)

	}
}
