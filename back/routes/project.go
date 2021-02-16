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
	path.GET("/do", middlewares.IsLoggedIn, controllers.DoneProject)

	path.GET("/all", controllers.GetAllProjects)
	path.GET("/unassigned", controllers.GetAllUnassignedProjects)
	path.GET("/assigned", controllers.GetAllAssignedProjects)
	path.GET("/", controllers.GetProject)

	user := path.Group("/user")

	user.GET("/all", controllers.GetAllUserProjects)
	user.GET("/unassigned", controllers.GetAllUserUnassignedProjects)
	user.GET("/assigned", controllers.GetAllUserAssignedProjects)
	user.GET("/accepted", middlewares.IsLoggedIn, controllers.GetAllUserAcceptedProjects)

	offer := path.Group("/offer")

	offer.GET("/p", middlewares.IsLoggedIn, controllers.GetProjectOffers)
	offer.GET("/u", middlewares.IsLoggedIn, controllers.GetUserOffers)
	offer.GET("/f", middlewares.IsLoggedIn, controllers.GetFreelancerOffers)

	comment := path.Group("/comment")

	comment.POST("/", middlewares.IsLoggedIn, controllers.CreateComment)
	comment.GET("/p", controllers.GetProjectComments)
	comment.DELETE("/", middlewares.IsLoggedIn, controllers.DeleteProjectComment)

}
