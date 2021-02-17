package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func projectRoutes(router *gin.RouterGroup) {
	project := router.Group("/project")

	project.POST("/new", middlewares.IsLoggedIn, controllers.CreateProject)
	project.GET("/assign", middlewares.IsLoggedIn, controllers.AssignProject)
	project.GET("/do", middlewares.IsLoggedIn, controllers.DoneProject)

	project.GET("/", controllers.GetProject)
	project.GET("/all", controllers.GetAllProjects)
	project.GET("/unassigned", controllers.GetAllUnassignedProjects)
	project.GET("/assigned", controllers.GetAllAssignedProjects)
	// to do get all done projects

	user := project.Group("/user")

	user.GET("/all", controllers.GetAllUserProjects)
	user.GET("/unassigned", controllers.GetAllUserUnassignedProjects)
	user.GET("/assigned", controllers.GetAllUserAssignedProjects)
	user.GET("/accepted", middlewares.IsLoggedIn, controllers.GetAllUserAcceptedProjects) // ???
	// to do get all user done projects

}
