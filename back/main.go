package main

import (
	"fmt"

	"github.com/gin-gonic/gin"

	"webprj/config"
	"webprj/routes"
)

func main() {
	// gin.SetMode(gin.ReleaseMode)

	router := gin.Default()

	router.Static("/static", "./assets")
	router.StaticFile("/favicon.ico", "./assets/favicon/favicon.ico")

	routes.InitializeRoutes(router)

	err := config.InitMongoDB2()
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("successfuly connected to MongoDB ...")
	}

	fmt.Println("server running on port 8080 ...")
	router.Run(":8080")

}
