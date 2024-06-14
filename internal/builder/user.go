package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/Kevinmajesta/depublic-backend/pkg/email"
	"github.com/Kevinmajesta/depublic-backend/pkg/encrypt"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func BuildPublicRoutes(db *gorm.DB, tokenUseCase token.TokenUseCase, encryptTool encrypt.EncryptTool, entityCfg *entity.Config) []*route.Route {
	emailService := email.NewEmailSender(entityCfg)
	userRepository := repository.NewUserRepository(db, nil)
	userService := service.NewUserService(userRepository, tokenUseCase, encryptTool, emailService)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, nil)
	adminService := service.NewAdminService(adminRepository, tokenUseCase, encryptTool, emailService)
	adminHandler := handler.NewAdminHandler(adminService)

	return router.PublicRoutes(userHandler, adminHandler)
}

func BuildPrivateRoutes(db *gorm.DB, redisDB *redis.Client, encryptTool encrypt.EncryptTool, entityCfg *entity.Config) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)
	userRepository := repository.NewUserRepository(db, cacheable)
	userService := service.NewUserService(userRepository, nil, encryptTool, nil)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, cacheable)
	adminService := service.NewAdminService(adminRepository, nil, encryptTool, nil)
	adminHandler := handler.NewAdminHandler(adminService)

	return router.PrivateRoutes(userHandler, adminHandler)
}
