package main

import (
	"github.com/Kevinmajesta/depublic-backend/configs"
	"github.com/Kevinmajesta/depublic-backend/internal/builder"
	"github.com/Kevinmajesta/depublic-backend/pkg/postgres"
	"github.com/Kevinmajesta/depublic-backend/pkg/server"
)

func main() {
	cfg, err := configs.NewConfig(".env")
	checkError(err)

	db, err := postgres.InitPostgres(&cfg.Postgres)
	checkError(err)

	// // CATEGORY
	// categoryPublicRoutes := builder.BuildCategoryPublicRoutes(db)
	// categoryPrivateRoutes := builder.BuildCategoryPrivateRoutes()

	// EVENT
	eventPublicRoutes := builder.BuildEventPublicRoutes(db)
	eventPrivateRoutes := builder.BuildEventPrivateRoutes()

	// srv := server.NewServer("app", categoryPublicRoutes, categoryPrivateRoutes)
	srv := server.NewServer("app", eventPublicRoutes, eventPrivateRoutes)
	srv.Run()
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}
