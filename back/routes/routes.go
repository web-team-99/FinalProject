// routes.go

package routes

import (
	"webprj/config"
	"webprj/middlewares"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

// InitializeRoutes api routes
func InitializeRoutes(router *gin.Engine) {
	router.Static("/static", "./assets")
	router.StaticFile("/favicon.ico", "./assets/favicon/favicon.ico")

	api := router.Group("/api")

	api.Use(middlewares.Connect)
	api.Use(sessions.Sessions("session", config.Store))

	// indexRoutes(api)
	userRoutes(api)
	projectRoutes(api)
	offerRoutes(api)
	commentRoutes(api)

}
