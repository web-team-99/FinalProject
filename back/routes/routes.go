// routes.go

package routes

import (
	"fmt"
	"webprj/middlewares"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/mongo"
	"github.com/gin-gonic/gin"
	"github.com/globalsign/mgo"
)

func test(c *gin.Context) {
	fmt.Println("recieved")
}

// InitializeRoutes api routes
func InitializeRoutes(router *gin.Engine) {
	api := router.Group("/api")

	api.Use(middlewares.Connect)

	session, err := mgo.Dial("localhost:27017/test")
	if err != nil {
		// handle err
	}

	c := session.DB("").C("Session")
	store := mongo.NewStore(c, 3600, true, []byte("secret"))
	api.Use(sessions.Sessions("mysession", store))

	indexRoutes(api)

	userRoutes(api)

	projectRoutes(api)

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
