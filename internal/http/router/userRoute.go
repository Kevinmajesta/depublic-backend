package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func UserPublicRoutes(userHandler handler.UserHandler, transactionHandler handler.TransactionHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodPost,
			Path:    "/login",
			Handler: userHandler.LoginUser,
		},

		{
			Method:  http.MethodPost,
			Path:    "transaction/create",
			Handler: transactionHandler.CreateTransaction,
		},

		{
			Method:  http.MethodGet,
			Path:    "transaction/all",
			Handler: transactionHandler.FindAllTransaction,
		},

		{
			Method:  http.MethodPost,
			Path:    "transaction/check-pay",
			Handler: transactionHandler.CheckPayTransaction,
		},
	}
}

func UserPrivateRoutes(userHandler handler.UserHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodGet,
			Path:    "/users",
			Handler: userHandler.FindAllUser,
		},
	}
}
