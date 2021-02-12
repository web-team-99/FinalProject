package middlewares

import (
	"fmt"
	"net/http"
	"regexp"
	"webprj/controllers"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

// IsLoggedIn middleware
func IsLoggedIn(c *gin.Context) {
	session := sessions.Default(c)
	userid := session.Get("userid")
	fmt.Println(userid)
	if userid == nil {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "unauthorized",
		})
		c.Abort()
		return
	}
	c.Set("userid", userid)
}

// IsEmailValid middleware
func IsEmailValid(c *gin.Context) {
	email, ok := c.GetPostForm("email")
	if ok {
		re := regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
		if re.MatchString(email) {
			c.Next()
			return
		}
		controllers.SendBadRequest(c, &gin.H{"message": "email is invalid"})
		return
	}
	controllers.SendBadRequest(c, &gin.H{"message": "Invalid request body (email)"})
}

// IsPassValid middleware
func IsPassValid(c *gin.Context) {
	password, ok := c.GetPostForm("password")
	if ok {
		if len(password) >= 8 {
			c.Next()
			return
		}
		controllers.SendBadRequest(c, &gin.H{"message": "password is invalid"})
		return
	}
	controllers.SendBadRequest(c, &gin.H{"message": "Invalid request body  (password)"})
}
