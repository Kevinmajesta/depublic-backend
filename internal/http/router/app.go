package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func AppPublicRoutes(categoryHandler handler.CategoryHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodPost,
			Path:    "/category",
			Handler: categoryHandler.AddCategory,
		},
	}
}

func AppPrivateRoutes() []*route.Route {
	return []*route.Route{}
}

// func AppPublicRoutes(categoriesHandler handler.CategoriesHandler) []*route.Route {
// 	return []*route.Route{
// 		// Route GET
// 		// {
// 		// 	Method:  http.MethodGet,
// 		// 	Path:    "/categories",
// 		// 	Handler: categoriesHandler.FindAllCategories,
// 		// },
// 		// {
// 		// 	Method:  http.MethodGet,
// 		// 	Path:    "/categories/:id",
// 		// 	Handler: categoriesHandler.FindCategoriesByID,
// 		// },
// 		// {
// 		// 	Method:  http.MethodGet,
// 		// 	Path:    "/categories/name",
// 		// 	Handler: categoriesHandler.FindCategoriesByName,
// 		// },
// 		// Route POST
// 		{
// 			Method:  http.MethodPost,
// 			Path:    "/categories/create",
// 			Handler: categoriesHandler.AddCategories,
// 		},
// 	}
// }

// func AppPrivateRoutes() []*route.Route {
// 	return []*route.Route{}
// }
