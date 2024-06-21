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

	wishlistRepository := repository.NewWishlistRepository(db, cacheable)
	wishlistService := service.NewWishlistService(wishlistRepository, notificationService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)

	//Event
	eventRepository := repository.NewEventRepository(db)
	eventService := service.NewEventService(eventRepository)
	eventHandler := handler.NewEventHandler(eventService)

	cartRepository := repository.NewCartRepository(db, cacheable)
	cartService := service.NewCartService(cartRepository, eventRepository, notificationService)
	cartHandler := handler.NewCartHandler(cartService)

	// Category
	categoryRepository := repository.NewCategoryRepository(db, cacheable)
	categoryService := service.NewCategoryService(categoryRepository)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	return router.PublicRoutes(userHandler, adminHandler, cartHandler, wishlistHandler, notificationHandler, eventHandler, categoryHandler)
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

	wishlistRepository := repository.NewWishlistRepository(db, cacheable)
	wishlistService := service.NewWishlistService(wishlistRepository, notificationService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService)

	eventRepository := repository.NewEventRepository(db)
	eventService := service.NewEventService(eventRepository)
	eventHandler := handler.NewEventHandler(eventService)

	cartRepository := repository.NewCartRepository(db, cacheable)
	cartService := service.NewCartService(cartRepository, eventRepository, notificationService)
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

// func SetupEcho(db *gorm.DB) *echo.Echo {
// 	e := echo.New()
// 	e.Validator = validator.NewValidator()

// 	eventHandler := handler.NewEventHandler(service.NewEventService(repository.NewEventRepository(db)))

// 	publicRoutes := router.EventPublicRoutes(eventHandler)
// 	for _, route := range publicRoutes {
// 		e.Add(route.Method, route.Path, route.Handler)
// 	}

// 	privateRoutes := router.EventPrivateRoutes()
// 	for _, route := range privateRoutes {
// 		e.Add(route.Method, route.Path, route.Handler)
// 	}

// 	return e
// }
