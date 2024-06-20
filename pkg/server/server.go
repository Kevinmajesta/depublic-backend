package server

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/Kevinmajesta/depublic-backend/pkg/response"
	"github.com/Kevinmajesta/depublic-backend/pkg/route"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
	echojwt "github.com/labstack/echo-jwt/v4"
	"github.com/labstack/echo/v4"
)

type Server struct {
	*echo.Echo
}

func NewServer(serverName string, userPublicRoutes, userPrivateRoutes, adminPublicRoutes, adminPrivateRoutes []*route.Route, secretKey string) *Server {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Hello, World!", nil))
	})

	v1 := e.Group(fmt.Sprintf("/%s/api/v1", serverName))

	// Add routes with optional middleware
	addRoutes(v1, userPublicRoutes, nil)
	addRoutes(v1, userPrivateRoutes, JWTProtection(secretKey, "admin"))
	addRoutes(v1, adminPublicRoutes, nil)
	addRoutes(v1, adminPrivateRoutes, JWTProtection(secretKey, "user"))

	return &Server{e}
}

func addRoutes(g *echo.Group, routes []*route.Route, middleware echo.MiddlewareFunc) {
	for _, r := range routes {
		if middleware != nil {
			g.Add(r.Method, r.Path, r.Handler, middleware)
		} else {
			g.Add(r.Method, r.Path, r.Handler)
		}
	}
}

func (s *Server) Run() {
	runServer(s)
	gracefulShutdown(s)
}

func runServer(srv *Server) {
	go func() {
		if err := srv.Start(":8080"); err != nil && err != http.ErrServerClosed {
			log.Fatal("Error starting server: ", err)
		}
	}()
}

func gracefulShutdown(srv *Server) {
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		srv.Logger.Fatal("Server Shutdown:", err)
	}
}

func JWTProtection(secretKey string, requiredRole string) echo.MiddlewareFunc {
	return echojwt.WithConfig(echojwt.Config{
		NewClaimsFunc: func(c echo.Context) jwt.Claims {
			return new(token.JwtCustomClaims)
		},
		SigningKey: []byte(secretKey),
		ErrorHandler: func(c echo.Context, err error) error {
			return c.JSON(http.StatusUnauthorized, response.ErrorResponse(http.StatusUnauthorized, "anda harus login untuk mengakses resource ini"))
		},
		SuccessHandler: func(c echo.Context) {
			claims := c.Get("user").(*jwt.Token).Claims.(*token.JwtCustomClaims)
			role := claims.Is_admin
			if role != requiredRole {
				// Hentikan eksekusi lebih lanjut dan kirim respons 403
				_ = c.JSON(http.StatusForbidden, response.ErrorResponse(http.StatusForbidden, "anda tidak memiliki akses ke resource ini"))
				c.Response().WriteHeader(http.StatusForbidden)
				c.Response().Flush()
				c.Error(fmt.Errorf("forbidden access"))
				return
			}

			// Jika peran sesuai, lanjutkan eksekusi
			return
		},
	})
}
