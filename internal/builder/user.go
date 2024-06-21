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

	// "github.com/labstack/echo/"

	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func BuildPublicRoutes(db *gorm.DB, redisDB *redis.Client, tokenUseCase token.TokenUseCase, encryptTool encrypt.EncryptTool,
	entityCfg *entity.Config) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)
	emailService := email.NewEmailSender(entityCfg)
	userRepository := repository.NewUserRepository(db, nil)

	notificationRepository := repository.NewNotificationRepository(db, cacheable)
	notificationService := service.NewNotificationService(notificationRepository, tokenUseCase, userRepository)
	notificationHandler := handler.NewNotificationHandler(notificationService)

	userService := service.NewUserService(userRepository, tokenUseCase, encryptTool, emailService, notificationService)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, nil)
	adminService := service.NewAdminService(adminRepository, tokenUseCase, encryptTool, emailService, notificationService)
	adminHandler := handler.NewAdminHandler(adminService)

	//Event
	eventRepository := repository.NewEventRepository(db)
	eventService := service.NewEventService(eventRepository)
	eventHandler := handler.NewEventHandler(eventService)

	// Category
	categoryRepository := repository.NewCategoryRepository(db, cacheable)
	categoryService := service.NewCategoryService(categoryRepository)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	return router.PublicRoutes(userHandler, adminHandler, notificationHandler, eventHandler, categoryHandler)
}

func BuildPrivateRoutes(db *gorm.DB, redisDB *redis.Client, encryptTool encrypt.EncryptTool, entityCfg *entity.Config) []*route.Route {
	cacheable := cache.NewCacheable(redisDB)
	userRepository := repository.NewUserRepository(db, cacheable)

	notificationRepository := repository.NewNotificationRepository(db, cacheable)
	notificationService := service.NewNotificationService(notificationRepository, nil, userRepository)
	notificationHandler := handler.NewNotificationHandler(notificationService)

	userService := service.NewUserService(userRepository, nil, encryptTool, nil, notificationService)
	userHandler := handler.NewUserHandler(userService)

	adminRepository := repository.NewAdminRepository(db, cacheable)
	adminService := service.NewAdminService(adminRepository, nil, encryptTool, nil, notificationService)
	adminHandler := handler.NewAdminHandler(adminService)

	eventRepository := repository.NewEventRepository(db)
	eventService := service.NewEventService(eventRepository)
	eventHandler := handler.NewEventHandler(eventService)

	wishlistRepository := repository.NewWishlistRepository(db, cacheable)
	wishlistService := service.NewWishlistService(wishlistRepository, eventRepository, userRepository, notificationService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)

	cartRepository := repository.NewCartRepository(db, cacheable)
	cartService := service.NewCartService(cartRepository, eventRepository, userRepository, notificationService)
	cartHandler := handler.NewCartHandler(cartService)

	transactionRepository := repository.NewTransactionRepository(db, cacheable)
	transactionService := service.NewTransactionService(transactionRepository)
	transactionHandler := handler.NewTransactionHandler(transactionService)

	categoryRepository := repository.NewCategoryRepository(db, cacheable)
	categoryService := service.NewCategoryService(categoryRepository)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	ticketRepository := repository.NewTicketRepository(db, cacheable)
	ticketService := service.NewTicketService(ticketRepository, nil)
	ticketHandler := handler.NewTicketHandler(ticketService)

	return router.PrivateRoutes(userHandler, adminHandler, transactionHandler,
		cartHandler, wishlistHandler, notificationHandler, eventHandler, categoryHandler, ticketHandler)
}
