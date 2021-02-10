// routes.go

package routes

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func test(c *gin.Context) {
	fmt.Println("recieved")
}

// InitializeRoutes api routes
func InitializeRoutes(router *gin.Engine) {
	api := router.Group("/api")

	indexRoutes(api)

	userRoutes(api)

	// unauthorized := api.Group("/")
	// unauthorized.Use(test)
	// publicRoutes(unauthorized)

	// authorized := api.Group("/user")
	// privateRoutes(authorized)

}

func publicRoutes(router *gin.RouterGroup) {
	router.GET("/login", test)
	router.POST("/register", test)
	router.GET("/jobs", test)
}

func privateRoutes(router *gin.RouterGroup) {
	router.GET("/", test, test)
	router.GET("/jobs", test)
}
