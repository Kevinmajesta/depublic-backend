package router

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/handler"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func EventPublicRoutes(eventHandler handler.EventHandler) []*route.Route {
	return []*route.Route{
		{
			Method:  http.MethodPost,
			Path:    "/event",
			Handler: eventHandler.AddEvent,
		},
		{
			Method:  http.MethodGet,
			Path:    "/event",
			Handler: eventHandler.GetAllEvent,
		},
		{
			Method:  http.MethodGet,
			Path:    "/event/",
			Handler: eventHandler.SearchEvents,
		},
		{
			Method:  http.MethodGet,
			Path:    "/event/:id",
			Handler: eventHandler.GetEventByID,
		},
		{
			Method:  http.MethodPut,
			Path:    "/event/:id",
			Handler: eventHandler.UpdateEvent,
		},
		{
			Method:  http.MethodDelete,
			Path:    "/event/:id",
			Handler: eventHandler.DeleteEventByID,
		},
	}
}

func EventPrivateRoutes() []*route.Route {
	return []*route.Route{}
}
