package routes

import (
	"webprj/controllers"
	"webprj/middlewares"

	"github.com/gin-gonic/gin"
)

func projectRoutes(router *gin.RouterGroup) {
	project := router.Group("/project")

	project.POST("/", middlewares.IsLoggedIn, controllers.CreateProject)
	project.GET("/assign", middlewares.IsLoggedIn, controllers.AssignProject)
	project.GET("/do", middlewares.IsLoggedIn, controllers.DoProject)

	project.GET("/", controllers.GetProject)
	project.GET("/all", controllers.GetAllProjects)
	project.GET("/unassigned", controllers.GetAllUnassignedProjects)
	project.GET("/assigned", controllers.GetAllAssignedProjects)
	project.GET("/done", controllers.GetAllDoneProjects)

	user := project.Group("/user")

	user.GET("/all", controllers.GetAllUserProjects)
	user.GET("/unassigned", controllers.GetAllUserUnassignedProjects)
	user.GET("/assigned", controllers.GetAllUserAssignedProjects)
	user.GET("/done", controllers.GetAllUserDoneProjects)
	user.GET("/accepted", middlewares.IsLoggedIn, controllers.GetAllUserAcceptedProjects)

}
