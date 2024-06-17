package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"gorm.io/gorm"
)

func BuildCategoryPublicRoutes(db *gorm.DB) []*route.Route {
	categoryRepository := repository.NewCategoryRepository(db)
	categoryService := service.NewCategoryService(categoryRepository)
	categoryHandler := handler.NewCategoryHandler(categoryService)
	return router.CategoryPublicRoutes(categoryHandler)
}

func BuildCategoryPrivateRoutes() []*route.Route {
	return router.CategoryPrivateRoutes()
}
