package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func userRoutes(router *gin.RouterGroup) {
	router.POST("/login", middlewares.IsEmailValid, middlewares.IsPassValid, controllers.Login)
	router.POST("/register", middlewares.IsEmailValid, middlewares.IsPassValid, controllers.Register)

	user := router.Group("/user")
	user.PUT("/", middlewares.IsLoggedIn, middlewares.IsEmailValid, controllers.UpdateUserInfo)
	user.GET("/", controllers.GetUserByID)
	user.GET("/cur", middlewares.IsLoggedIn, controllers.GetCurrentUser)
	user.GET("/all", controllers.GetAllUsers)
}
