package main

import (
	"github.com/Kevinmajesta/depublic-backend/internal/builder"
	"github.com/Kevinmajesta/depublic-backend/pkg/server"
)

func main() {
	publicRoutes := builder.BuildAuthPublicRoutes()
	privateRoutes := builder.BuildAuthPrivateRoutes()

	srv := server.NewServer("auth", publicRoutes, privateRoutes)
	srv.Run()
}
