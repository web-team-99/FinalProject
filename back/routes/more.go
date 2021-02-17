package routes

import (
	"webprj/controllers"

	"github.com/gin-gonic/gin"
)

func moreRoutes(router *gin.RouterGroup) {
	router.GET("/contactus", controllers.GetContactUs)
}
