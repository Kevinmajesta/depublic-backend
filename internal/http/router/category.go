package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func CategoryPublicRoutes(categoryHandler handler.CategoryHandler) []*route.Route {
	return []*route.Route{
		// TODO ROUTE GET
		{
			Method:  http.MethodGet,
			Path:    "/category",
			Handler: categoryHandler.GetAllCategory,
		},
		// By ID
		{
			Method:  http.MethodGet,
			Path:    "/category/:id",
			Handler: categoryHandler.GetCategoryByID,
		},
		// By Param
		{
			Method:  http.MethodGet,
			Path:    "/category/",
			Handler: categoryHandler.GetCategoryByParam,
		},
		// TODO ROUTE POST
		{
			Method:  http.MethodPost,
			Path:    "/category",
			Handler: categoryHandler.AddCategory,
		},
		// TODO ROUTE PUT
		{
			Method:  http.MethodPut,
			Path:    "/category/:id",
			Handler: categoryHandler.UpdateCategoryByID,
		},
		// TODO ROUTE DELETE
		{
			Method:  http.MethodDelete,
			Path:    "/category/:id",
			Handler: categoryHandler.DeleteCategoryByID,
		},
	}
}

func CategoryPrivateRoutes() []*route.Route {
	return []*route.Route{}
}
