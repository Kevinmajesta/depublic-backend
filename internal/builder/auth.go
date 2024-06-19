package builder

import (
	"github.com/Kevinmajesta/depublic-backend/internal/http/router"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
)

func BuildAuthPublicRoutes() []*route.Route {
	return router.AuthPublicRoutes()
}

func BuildAuthPrivateRoutes() []*route.Route {
	return router.AuthPrivateRoutes()
}
