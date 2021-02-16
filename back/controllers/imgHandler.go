package controllers

import (
	"fmt"
	"net/http"
	"path/filepath"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func saveImage(c *gin.Context, path string) (staticPath string) {
	file, err := c.FormFile("image")

	// The file cannot be received.
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": "No file is received",
		})
		return ""
	}

	// Retrieve file information
	extension := filepath.Ext(file.Filename)
	// Generate random file name for the new uploaded file so it doesn't override the old file with same name
	newFileName := uuid.New().String() + extension

	staticPath = path + newFileName

	// The file is received, so let's save it
	if err := c.SaveUploadedFile(file, "./assets"+staticPath); err != nil {
		fmt.Println(err)
		c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
			"message": "Unable to save the file",
		})
		return ""
	}

	staticPath = "/static" + staticPath

	// c.JSON(http.StatusOK, gin.H{
	// 	"message": "Your file has been successfully uploaded.",
	// })

	return staticPath

}
