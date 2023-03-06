package main

import (
	"log"
)

func main() {

	log.Println("running...")
	stor, err := NewPostgresStore()
	if err != nil {
		log.Fatal(err)
	}
	service := NewAPIService(":8000", stor)
	service.Run()

}
