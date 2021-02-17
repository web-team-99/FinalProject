package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func offerRoutes(router *gin.RouterGroup) {
	offer := router.Group("/offer")
	offer.Use(middlewares.IsLoggedIn)

	offer.POST("/", controllers.CreateOffer)
	offer.GET("/project", controllers.GetProjectOffers)
	offer.GET("/user", controllers.GetUserOffers)
	offer.GET("/freelancer", controllers.GetFreelancerOffers)
}
