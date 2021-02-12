package config

import (
	"errors"
	"os"

	mgo "gopkg.in/mgo.v2"
)

var Session *mgo.Session

var Mongo *mgo.DialInfo

var db *mgo.Database

func InitMongoDB() error {
	host := os.Getenv("MONGO_HOST")
	dbName := os.Getenv("MONGO_DB_NAME")

	session, err := mgo.Dial(host)
	if err != nil {
		return err
	}
	session.SetSafe(&mgo.Safe{})

	db = session.DB(dbName)
	return nil
}

func InitMongoDB2() error {
	host := os.Getenv("MONGO_HOST")
	// dbName := os.Getenv("MONGO_DB_NAME")

	mongo, err := mgo.ParseURL(host)

	session, err := mgo.Dial(host)
	if err != nil {
		return err
	}
	session.SetSafe(&mgo.Safe{})
	Session = session
	Mongo = mongo
	// db = session.DB(dbName)
	return nil
}

func GetMongoDB() (*mgo.Database, error) {
	if db == nil {
		return nil, errors.New("db is nil")
	}
	return db, nil
}
