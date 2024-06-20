package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func BuildUserPublicRoutes(db *gorm.DB, redisDB *redis.Client, tokenUseCase token.TokenUseCase) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)
	userRepository := repository.NewUserRepository(db)
	userService := service.NewUserService(userRepository, tokenUseCase)
	userHandler := handler.NewUserHandler(userService)

	// Route Transaction

	transactionRepository := repository.NewTransactionRepository(db, cacheable)
	transactionService := service.NewTransactionService(transactionRepository)
	transactionHandler := handler.NewTransactionHandler(transactionService)

	return router.UserPublicRoutes(userHandler, transactionHandler)
}

func BuildUserPrivateRoutes(db *gorm.DB, redisDB *redis.Client) []*route.Route {
	userRepository := repository.NewUserRepository(db)
	userService := service.NewUserService(userRepository, nil)
	userHandler := handler.NewUserHandler(userService)

	return router.UserPrivateRoutes(userHandler)
}
