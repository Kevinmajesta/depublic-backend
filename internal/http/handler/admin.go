package handler

import (
	"net/http"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/http/binder"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/response"
	"github.com/google/uuid"
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

func (h *AdminHandler) FindAllUser(c echo.Context) error {
	users, err := h.adminService.FindAllUser()
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses menampilkan data user", users))
}

func (h *AdminHandler) CreateAdmin(c echo.Context) error {
	input := binder.AdminCreateRequest{}

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}
	if h.adminService.EmailExists(input.Email) {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "email sudah digunakan"))
	}

	newAdmin := entity.NewAdmin(input.Fullname, input.Email, input.Password, input.Role, input.Phone, input.Verification)
	admin, err := h.adminService.CreateAdmin(newAdmin)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses membuat admin baru", admin))
}

func (h *AdminHandler) UpdateAdmin(c echo.Context) error {
	var input binder.AdminUpdateRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	id := uuid.MustParse(input.Admin_ID)

	inputAdmin := entity.UpdateAdmin(id, input.Fullname, input.Email, input.Password, input.Role, input.Phone, input.Verification)

	updatedAdmin, err := h.adminService.UpdateAdmin(inputAdmin)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}
	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses update admin", updatedAdmin))
}

func (h *AdminHandler) DeleteAdmin(c echo.Context) error {
	var input binder.AdminDeleteRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	id := uuid.MustParse(input.Admin_ID)

	isDeleted, err := h.adminService.DeleteAdmin(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses delete admin", isDeleted))
}
