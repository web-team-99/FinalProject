package config

import (
	"os"

	"github.com/gin-contrib/sessions/mongo"
	"github.com/globalsign/mgo"
	mgov2 "gopkg.in/mgo.v2"
)

var Session *mgov2.Session

var Mongo *mgov2.DialInfo

var Store mongo.Store

func InitMongoDB() error {
	host := os.Getenv("MONGO_HOST")
	mongo, err := mgov2.ParseURL(host)
	session, err := mgov2.Dial(host)
	if err != nil {
		return err
	}
	session.SetSafe(&mgov2.Safe{})
	Session = session
	Mongo = mongo
	return nil
}

func InitSession() error {
	session, err := mgo.Dial("localhost:27017/test")
	if err != nil {
		return err
	}
	col := session.DB(os.Getenv("MONGO_DB_NAME")).C("Session")
	store := mongo.NewStore(col, 3600, true, []byte("secret"))
	Store = store
	return nil
}
