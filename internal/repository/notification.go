package repository

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type NotificationRepository interface {
	GetUserNotifications(userID uuid.UUID) ([]*entity.Notification, error)
	CreateNotification(notification *entity.Notification) error
	MarkNotificationAsRead(notificationID uuid.UUID) error
}

type notificationRepository struct {
	db        *gorm.DB
	cacheable cache.Cacheable
}

func NewNotificationRepository(db *gorm.DB, cacheable cache.Cacheable) *notificationRepository {
	return &notificationRepository{db: db, cacheable: cacheable}
}

func (r *notificationRepository) GetUserNotifications(userID uuid.UUID) ([]*entity.Notification, error) {
	var notifications []*entity.Notification
	result := r.db.Where("user_id = ?", userID).Find(&notifications)
	if result.Error != nil {
		return nil, result.Error
	}

	for _, notification := range notifications {
		// Assuming you have a method to update the is_read field
		err := r.MarkNotificationAsRead(notification.Notification_ID)
		if err != nil {
			return nil, err
		}
	}

	return notifications, nil
}

func (r *notificationRepository) CreateNotification(notification *entity.Notification) error {
	return r.db.Create(notification).Error
}

func (r *notificationRepository) MarkNotificationAsRead(notificationID uuid.UUID) error {
	return r.db.Model(&entity.Notification{}).Where("notification_id = ?", notificationID).Update("is_read", true).Error
}





