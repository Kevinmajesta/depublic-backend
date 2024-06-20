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

type NotificationHandler struct {
	notificationService service.NotificationService
}

func NewNotificationHandler(notificationService service.NotificationService) NotificationHandler {
	return NotificationHandler{notificationService: notificationService}
}

// GetAllNotification
func (h *NotificationHandler) GetUserNotifications(c echo.Context) error {
	input := binder.MarkNotificationAsRead{}

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid request body"))
	}

	userID, err := uuid.Parse(input.UserId)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid user ID"))
	}

	notifications, err := h.notificationService.GetUserNotifications(userID)
	if err != nil {
		return c.JSON(http.StatusUnprocessableEntity, response.ErrorResponse(http.StatusUnprocessableEntity, err.Error()))
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"data": notifications,
	})
}

// CreateNotification
func (h *NotificationHandler) CreateNotification(c echo.Context) error {
	var input entity.Notification

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid request"))
	}

	if err := h.notificationService.CreateNotification(&input); err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	return c.JSON(http.StatusCreated, input)
}

// MarkNotificationAsRead
func (h *NotificationHandler) MarkNotificationAsRead(c echo.Context) error {
	notificationID, err := uuid.Parse(c.Param("notification_id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid notification ID"))
	}

	if err := h.notificationService.MarkNotificationAsRead(notificationID); err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	return c.NoContent(http.StatusNoContent)
}


