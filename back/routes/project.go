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

	path.GET("/all", controllers.GetAllProjects)
	path.GET("/unassigned", controllers.GetAllUnassignedProjects)
	path.GET("/assigned", controllers.GetAllAssignedProjects)

	user := path.Group("/user")

	user.GET("/all", controllers.GetAllUserProjects)
	user.GET("/unassigned", controllers.GetAllUserUnassignedProjects)
	user.GET("/assigned", controllers.GetAllUserAssignedProjects)
	user.GET("/accepted", controllers.GetAllUserAcceptedProjects)

	offer := path.Group("/offer")

	offer.GET("/p", middlewares.IsLoggedIn, controllers.GetPostOffers)
	offer.GET("/u", middlewares.IsLoggedIn, controllers.GetUserOffers)
	offer.GET("/f", middlewares.IsLoggedIn, controllers.GetFreelancerOffers)

}
