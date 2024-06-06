package handler

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/http/binder"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/response"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type AdminHandler struct {
	adminService service.AdminService
}

func NewAdminHandler(adminService service.AdminService) AdminHandler {
	return AdminHandler{adminService: adminService}
}

func (h *AdminHandler) LoginAdmin(c echo.Context) error {
	input := binder.AdminLoginRequest{}

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	admin, err := h.adminService.LoginAdmin(input.Email, input.Password)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "login success", admin))
}

func (h *AdminHandler) FindAllAdmin(c echo.Context) error {
	// Periksa peran pengguna
	user := c.Get("user").(*jwt.Token)
	claims := user.Claims.(*token.JwtCustomClaims)
	requiredRole := "admin"
	if claims.Is_admin != requiredRole {
		// Jika peran tidak sesuai, kirim respons 403 Forbidden
		return c.JSON(http.StatusForbidden, response.ErrorResponse(http.StatusForbidden, "anda tidak memiliki akses ke resource ini"))
	}

	// Ambil data admin hanya jika peran sesuai
	admins, err := h.adminService.FindAllAdmin()
	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"message": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"message": "sukses menampilkan data Admin",
		"admins":  admins,
	})
}
