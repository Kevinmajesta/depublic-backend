package binder

type CreateNotification struct {
	Type    string `json:"type" validate:"required"`
	Message string `json:"message" validate:"required"`
	Is_Read bool   `json:"is_read"`
}

type MarkNotificationAsRead struct {
	UserId string `json:"user_id" validate:"required"`
}

type GetNotificationsIdByUserId struct {
	Notification_ID string `json:"notification_id" validate:"required"`
	UserId          string `json:"user_id" validate:"required"`
}
