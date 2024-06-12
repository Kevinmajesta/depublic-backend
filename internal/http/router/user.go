package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

const (
	Admin = "admin"
	User  = "user"
)

var (
	allRoles  = []string{Admin, User}
	onlyAdmin = []string{Admin}
	onlyUser  = []string{User}
)

func PublicRoutes(userHandler handler.UserHandler,
	adminHandler handler.AdminHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodPost,
			Path:    "/login",
			Handler: userHandler.LoginUser,
		},
		{
			Method:  http.MethodPost,
			Path:    "/users",
			Handler: userHandler.CreateUser,
		},
		{
			Method:  http.MethodPost,
			Path:    "/login/admin",
			Handler: adminHandler.LoginAdmin,
		},
		{
			Method:  http.MethodPost,
			Path:    "/admins",
			Handler: adminHandler.CreateAdmin,
		},
	}
}

func PrivateRoutes(userHandler handler.UserHandler,
	adminHandler handler.AdminHandler) []*route.Route {
	return []*route.Route{

		{
			Method:  http.MethodPut,
			Path:    "/users/:user_id",
			Handler: userHandler.UpdateUser,
			Roles:   allRoles,
		},
		{
			Method:  http.MethodDelete,
			Path:    "/users/:user_id",
			Handler: userHandler.DeleteUser,
			Roles:   allRoles,
		},
		{
			Method:  http.MethodGet,
			Path:    "/users",
			Handler: adminHandler.FindAllUser,
			Roles:   onlyAdmin,
		},
		{
			Method:  http.MethodPut,
			Path:    "/admins/:user_id",
			Handler: adminHandler.UpdateAdmin,
			Roles:   onlyAdmin,
		},
		{
			Method:  http.MethodDelete,
			Path:    "/admins/:user_id",
			Handler: adminHandler.DeleteAdmin,
			Roles:   onlyAdmin,
		},
		{
			Method:  http.MethodGet,
			Path:    "/users/:user_id",
			Handler: userHandler.GetUserProfile,
			Roles:   allRoles,
		},
	}
}