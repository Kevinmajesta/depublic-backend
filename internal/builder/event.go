package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"gorm.io/gorm"
)

// func BuildEventPublicRoutes(db *gorm.DB) []*route.Route {
// 	eventRepository := repository.NewEventRepository(db)
// 	eventService := service.NewEventService(eventRepository)
// 	eventHandler := handler.NewEventHandler(eventService)
// 	return router.EventPublicRoutes(eventHandler)

// }

// func BuildEventPrivateRoutes() []*route.Route {
// 	return router.EventPrivateRoutes()
// }

func BuildEventPublicRoutes(db *gorm.DB) []*route.Route {
	eventRepository := repository.NewEventRepository(db)
	eventService := service.NewEventService(eventRepository)
	eventHandler := handler.NewEventHandler(eventService)
	return router.EventPublicRoutes(eventHandler)
}

func BuildEventPrivateRoutes() []*route.Route {
	return router.EventPrivateRoutes()
}

// SETUP Validator Upload file

// func SetupEcho() *echo.Echo {
// 	e := echo.New()
// 	e.Validator = validator.NewValidator() // Daftarkan validator
// 	return e
// }

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
