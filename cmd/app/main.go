package main

import (
	"github.com/Kevinmajesta/depublic-backend/configs"
	"github.com/Kevinmajesta/depublic-backend/internal/builder"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/Kevinmajesta/depublic-backend/pkg/postgres"
	"github.com/Kevinmajesta/depublic-backend/pkg/server"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
)

func main() {
	cfg, err := configs.NewConfig(".env")
	checkError(err)

	db, err := postgres.InitPostgres(&cfg.Postgres)
	checkError(err)

	redisDB := cache.InitCache(&cfg.Redis)

	tokenUseCase := token.NewTokenUseCase(cfg.JWT.SecretKey)

	adminPublicRoutes := builder.BuildAdminPublicRoutes(db, tokenUseCase)
	adminPrivateRoutes := builder.BuildAdminPrivateRoutes(db)
	userPublicRoutes := builder.BuildUserPublicRoutes(db, redisDB, tokenUseCase)
	userPrivateRoutes := builder.BuildUserPrivateRoutes(db, redisDB)

	srv := server.NewServer("app", adminPublicRoutes, adminPrivateRoutes, userPublicRoutes, userPrivateRoutes, cfg.JWT.SecretKey)
	srv.Run()
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}
