package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"gorm.io/gorm"
)

func BuildAdminPublicRoutes(db *gorm.DB, tokenUseCase token.TokenUseCase) []*route.Route {
	adminRepository := repository.NewAdminRepository(db)
	adminService := service.NewAdminService(adminRepository, tokenUseCase)
	adminHandler := handler.NewAdminHandler(adminService)
	return router.AdminPublicRoutes(adminHandler)
}

func BuildAdminPrivateRoutes(db *gorm.DB) []*route.Route {
	adminRepository := repository.NewAdminRepository(db)
	adminService := service.NewAdminService(adminRepository, nil)
	adminHandler := handler.NewAdminHandler(adminService)
	return router.AdminPrivateRoutes(adminHandler)
}
