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

type UserHandler struct {
	userService service.UserService
}

func NewUserHandler(userService service.UserService) UserHandler {
	return UserHandler{userService: userService}
}

func (h *UserHandler) LoginUser(c echo.Context) error {
	input := binder.UserLoginRequest{}

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	user, err := h.userService.LoginUser(input.Email, input.Password)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "login success", user))
}

func (h *UserHandler) CreateUser(c echo.Context) error {
	input := binder.UserCreateRequest{}

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}
	if h.userService.EmailExists(input.Email) {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "email sudah digunakan"))
	}

	newUser := entity.NewUser(input.Fullname, input.Email, input.Password, input.Phone, input.Role, input.Status, input.Verification)
	user, err := h.userService.CreateUser(newUser)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses membuat user baru", user))
}

func (h *UserHandler) UpdateUser(c echo.Context) error {
	var input binder.UserUpdateRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	id := uuid.MustParse(input.User_ID)

	inputUser := entity.UpdateUser(id, input.Fullname, input.Email, input.Password, input.Phone, input.Role, input.Status, input.Verification)

	updatedUser, err := h.userService.UpdateUser(inputUser)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses update user", updatedUser))
}

func (h *UserHandler) DeleteUser(c echo.Context) error {
	var input binder.UserDeleteRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	id := uuid.MustParse(input.User_ID)

	isDeleted, err := h.userService.DeleteUser(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses delete user", isDeleted))
}

func (h *UserHandler) GetUserProfile(c echo.Context) error {
	// Dapatkan ID pengguna dari parameter URL
	user_ID := c.Param("user_id")

	// Panggil layanan untuk mendapatkan profil pengguna berdasarkan ID
	user, err := h.userService.GetUserProfileByID(user_ID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Gagal mendapatkan profil pengguna"))
	}

	// Mengembalikan data profil pengguna sebagai respons JSON
	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "sukses menampilkan user", user))
}
