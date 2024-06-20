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

func BuildPublicRoutes(db *gorm.DB, redisDB *redis.Client, tokenUseCase token.TokenUseCase, encryptTool encrypt.EncryptTool,
	entityCfg *entity.Config) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)
	emailService := email.NewEmailSender(entityCfg)

	notificationRepository := repository.NewNotificationRepository(db, cacheable)
	notificationService := service.NewNotificationService(notificationRepository, tokenUseCase)
	notificationHandler := handler.NewNotificationHandler(notificationService)

	userRepository := repository.NewUserRepository(db, nil)
	userService := service.NewUserService(userRepository, tokenUseCase, encryptTool, emailService, notificationService)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, nil)
	adminService := service.NewAdminService(adminRepository, tokenUseCase, encryptTool, emailService, notificationService)
	adminHandler := handler.NewAdminHandler(adminService)

	wishlistRepository := repository.NewWishlistRepository(db, cacheable)
	wishlistService := service.NewWishlistService(wishlistRepository, notificationService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)

	eventRepository := repository.NewEventRepository(db)

	cartRepository := repository.NewCartRepository(db, cacheable)
	cartService := service.NewCartService(cartRepository, eventRepository, notificationService)
	cartHandler := handler.NewCartHandler(cartService)

	return router.PublicRoutes(userHandler, adminHandler, cartHandler, wishlistHandler, notificationHandler)
}

func BuildPrivateRoutes(db *gorm.DB, redisDB *redis.Client, encryptTool encrypt.EncryptTool, entityCfg *entity.Config) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)

	notificationRepository := repository.NewNotificationRepository(db, cacheable)
	notificationService := service.NewNotificationService(notificationRepository, nil)
	notificationHandler := handler.NewNotificationHandler(notificationService)

	userRepository := repository.NewUserRepository(db, cacheable)
	userService := service.NewUserService(userRepository, nil, encryptTool, nil, notificationService)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, cacheable)
	adminService := service.NewAdminService(adminRepository, nil, encryptTool, nil, notificationService)
	adminHandler := handler.NewAdminHandler(adminService)

	wishlistRepository := repository.NewWishlistRepository(db, cacheable)
	wishlistService := service.NewWishlistService(wishlistRepository, notificationService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)

	eventRepository := repository.NewEventRepository(db)

	cartRepository := repository.NewCartRepository(db, cacheable)
	cartService := service.NewCartService(cartRepository, eventRepository, notificationService)
	cartHandler := handler.NewCartHandler(cartService)

	transactionRepository := repository.NewTransactionRepository(db, cacheable)
	transactionService := service.NewTransactionService(transactionRepository)
	transactionHandler := handler.NewTransactionHandler(transactionService)

	return router.PrivateRoutes(userHandler, adminHandler, transactionHandler, cartHandler, wishlistHandler, notificationHandler)
}
