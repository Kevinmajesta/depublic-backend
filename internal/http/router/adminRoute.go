package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func AdminPublicRoutes(adminHandler handler.AdminHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodPost,
			Path:    "/login/admin",
			Handler: adminHandler.LoginAdmin,
		},
	}
}

func AdminPrivateRoutes(adminHandler handler.AdminHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodGet,
			Path:    "/admins",
			Handler: adminHandler.FindAllAdmin,
		},
	}
}
