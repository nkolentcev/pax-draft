package main

import "log"

func main() {
	log.Println("running...")
	service := NewAPIService(":8000")
	service.Run()
}
