package main

import (
	"github.com/Kevinmajesta/depublic-backend/configs"
	"github.com/Kevinmajesta/depublic-backend/internal/builder"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/Kevinmajesta/depublic-backend/pkg/encrypt"
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

	encryptTool := encrypt.NewEncryptTool(cfg.Encrypt.SecretKey, cfg.Encrypt.IV)

	tokenUseCase := token.NewTokenUseCase(cfg.JWT.SecretKey)

	PublicRoutes := builder.BuildPublicRoutes(db, tokenUseCase, encryptTool)
	PrivateRoutes := builder.BuildPrivateRoutes(db, redisDB, encryptTool)

	srv := server.NewServer("app", PublicRoutes, PrivateRoutes, cfg.JWT.SecretKey)
	srv.Run()
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}
