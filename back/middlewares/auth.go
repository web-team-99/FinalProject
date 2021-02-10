package middlewares

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

// middleware
func IsLoggedIn(c *gin.Context) {
	fmt.Println(c.Request.Body)
}
