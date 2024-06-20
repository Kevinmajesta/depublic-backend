package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/google/uuid"
)

type NotificationService interface {
	GetUserNotifications(userID uuid.UUID) ([]*entity.Notification, error)
	CreateNotification(notification *entity.Notification) error
	MarkNotificationAsRead(notificationID uuid.UUID) error
}

type notificationService struct {
	notificationRepo repository.NotificationRepository
	tokenUseCase     token.TokenUseCase
}

func NewNotificationService(notificationRepo repository.NotificationRepository, tokenUseCase token.TokenUseCase) NotificationService {
	return &notificationService{
		notificationRepo: notificationRepo,
		tokenUseCase:     tokenUseCase,
	}
}

func (s *notificationService) GetUserNotifications(userID uuid.UUID) ([]*entity.Notification, error) {
	return s.notificationRepo.GetUserNotifications(userID)
}

func (s *notificationService) CreateNotification(notification *entity.Notification) error {
	return s.notificationRepo.CreateNotification(notification)
}

func (s *notificationService) MarkNotificationAsRead(notificationID uuid.UUID) error {
	return s.notificationRepo.MarkNotificationAsRead(notificationID)
}
