package middlewares

import (
	"webprj/config"

	"github.com/gin-gonic/gin"
)

// Connect middleware
func Connect(c *gin.Context) {
	s := config.Session.Clone()

	defer s.Close()

	c.Set("db", s.DB(config.Mongo.Database))
	c.Next()
}
