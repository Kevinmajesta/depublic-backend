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
	adminHandler handler.AdminHandler, cartHandler handler.CartHandler,
	wishlistHandler handler.WishlistHandler, notificationHandler handler.NotificationHandler) []*route.Route {
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
		{
			Method:  http.MethodPost,
			Path:    "/password-reset-request",
			Handler: userHandler.RequestPasswordReset,
		},
		{
			Method:  http.MethodPost,
			Path:    "/verification-account",
			Handler: userHandler.VerifUser,
		},
		{
			Method:  http.MethodPost,
			Path:    "/password-reset",
			Handler: userHandler.ResetPassword,
		},
		{
			Method:  http.MethodGet,
			Path:    "/wishlist",
			Handler: wishlistHandler.GetAllWishlist,
		},
		{
			Method:  http.MethodPost,
			Path:    "/wishlist/create",
			Handler: wishlistHandler.AddWishlist,
		},
		{
			Method:  http.MethodDelete,
			Path:    "/wishlist/remove",
			Handler: wishlistHandler.RemoveWishlist,
		},
		{
			Method:  http.MethodGet,
			Path:    "/cart",
			Handler: cartHandler.GetAllCarts,
		},
		{
			Method:  http.MethodPost,
			Path:    "/cart",
			Handler: cartHandler.AddToCart,
		},
		{
			Method:  http.MethodPost,
			Path:    "/cart/less",
			Handler: cartHandler.UpdateQuantityLess,
		},
		{
			Method:  http.MethodPost,
			Path:    "/cart/add",
			Handler: cartHandler.UpdateQuantityAdd,
		},
		{
			Method:  http.MethodGet,
			Path:    "/cart/:id",
			Handler: cartHandler.GetCartById,
		},
		{
			Method:  http.MethodGet,
			Path:    "/cart/:id",
			Handler: cartHandler.GetCartByUserId,
		},
		{
			Method:  http.MethodDelete,
			Path:    "/cart/:id",
			Handler: cartHandler.RemoveCart,
		},
	}
}

func PrivateRoutes(userHandler handler.UserHandler,
	adminHandler handler.AdminHandler,
	transactionHandler handler.TransactionHandler, cartHandler handler.CartHandler,
	wishlistHandler handler.WishlistHandler, notificationHandler handler.NotificationHandler) []*route.Route {
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

		{
			Method:  http.MethodPost,
			Path:    "transaction/create",
			Handler: transactionHandler.CreateTransaction,
			Roles:   allRoles,
		},
		{
			Method:  http.MethodGet,
			Path:    "transaction/all",
			Handler: transactionHandler.FindAllTransaction,
			Roles:   onlyAdmin,
		},
		{
			Method:  http.MethodPost,
			Path:    "transaction/check-pay",
			Handler: transactionHandler.CheckPayTransaction,
			Roles:   allRoles,
		},
		{
			Method:  http.MethodPost,
			Path:    "/notification",
			Handler: notificationHandler.CreateNotification,
			Roles:   onlyAdmin,
		},
		{
			Method:  http.MethodGet,
			Path:    "/user/notification",
			Handler: notificationHandler.GetUserNotifications,
			Roles:   allRoles,
		},
	}
}
