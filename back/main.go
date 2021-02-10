package main

import (
	"fmt"
	// "webprj/routes"
	//"net/http"
	"github.com/gin-gonic/gin"
	// ".routes"
	// "back/routes"
	"webprj/routes"
)

// var router *gin.Engine

func main() {
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()
	routes.InitializeRoutes(router)
	fmt.Println("server running ...")
	router.Run()

}
