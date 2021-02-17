package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func offerRoutes(router *gin.RouterGroup) {
	offer := router.Group("/offer")

	offer.POST("/new", middlewares.IsLoggedIn, controllers.CreateOffer)
	offer.GET("/project", middlewares.IsLoggedIn, controllers.GetProjectOffers)
	offer.GET("/user", middlewares.IsLoggedIn, controllers.GetUserOffers)
	offer.GET("/freelancer", middlewares.IsLoggedIn, controllers.GetFreelancerOffers)
}
