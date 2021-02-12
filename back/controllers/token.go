package controllers

import (
	"os"
	"time"

	"github.com/dgrijalva/jwt-go"
	"gopkg.in/mgo.v2/bson"
)

// const expirationPeriod = time.Hour * 24
const expirationPeriod = time.Minute * 1

var secretKey = []byte(os.Getenv("ACCESS_SECRET"))

// GenerateToken generates a jwt token and store the username as a claim
func GenerateToken(userid bson.ObjectId) (string, error) {

	token := jwt.New(jwt.SigningMethodHS256)

	// Create a map to store our claims
	claims := token.Claims.(jwt.MapClaims)
	claims["userid"] = userid
	claims["exp"] = time.Now().Add(expirationPeriod).Unix()

	// SecretKey := []byte(os.Getenv("ACCESS_SECRET"))

	// producing the token string
	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

// ParseToken parses a jwt token and returns the username from claims
func ParseToken(tokenStr string) (bson.ObjectId, error) {

	//creating the token
	token, err := jwt.Parse(tokenStr, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil {
		return "", err
	}

	// extracting userid
	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		useridstr := claims["userid"].(string)
		userid := bson.ObjectIdHex(useridstr)
		return userid, nil
	} else {
		return "", err
	}
}

func CreateToken(userid bson.ObjectId) (string, error) {
	var err error
	//Creating Access Token
	// os.Setenv("ACCESS_SECRET", "jdnfksdmfksd") //this should be in an env file
	atClaims := jwt.MapClaims{}
	atClaims["authorized"] = true
	atClaims["user_id"] = userid
	atClaims["exp"] = time.Now().Add(time.Minute * 15).Unix()
	at := jwt.NewWithClaims(jwt.SigningMethodHS256, atClaims)
	token, err := at.SignedString([]byte(os.Getenv("ACCESS_SECRET")))
	if err != nil {
		return "", err
	}
	return token, nil
}
