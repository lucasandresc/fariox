package main

import (
	"fmt"

	"github.com/lucasandresc/fariox/backend/internal/database"
)

func main() {
	pool, err := database.Connect()
	if err != nil {
		fmt.Println("Error connecting to database", err)
		return
	}
	defer pool.Close()
	fmt.Println("Database connected")
}
