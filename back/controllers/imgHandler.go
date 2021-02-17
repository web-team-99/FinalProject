package controllers

import (
	"errors"
	"fmt"
	"path/filepath"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func newImagePath(c *gin.Context, path string) (newPath string, staticPath string) {
	file, err := c.FormFile("image")

	if err != nil {
		fmt.Println(err)
		return "", ""
	}

	extension := filepath.Ext(file.Filename)
	newFileName := uuid.New().String() + extension

	newPath = path + newFileName
	staticPath = "/static" + newPath

	return newPath, staticPath
}

func saveImage(c *gin.Context, path string) error {
	if path == "" {
		return errors.New("image not found")
	}
	file, err := c.FormFile("image")
	if err != nil {
		fmt.Println(err)
		return err
	}
	if err := c.SaveUploadedFile(file, "./assets"+path); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}
