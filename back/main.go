package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"

	"webprj/config"
	"webprj/routes"
)

func init() {
	err := config.InitMongoDB()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	} else {
		fmt.Println("successfuly connected to MongoDB ...")
	}

	err = config.InitSession()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func main() {
	// gin.SetMode(gin.ReleaseMode)

	router := gin.Default()

	routes.InitializeRoutes(router)

	fmt.Println("server running on port 8080 ...")
	router.Run(":8080")

}
