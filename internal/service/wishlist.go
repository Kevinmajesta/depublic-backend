package service

import (
	"errors"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/google/uuid"
)

type WishlistService interface {
	GetAllWishlist() ([]entity.Wishlist, error)
	AddWishlist(wishlist *entity.Wishlist) (*entity.Wishlist, error)
	RemoveWishlist(EventId, UserId uuid.UUID) (*entity.Wishlist, error)
}

type wishlistService struct {
	wishlistRepository  repository.WishlistRepository
	notificationService NotificationService
}

func NewWishlistService(wishlistRepository repository.WishlistRepository, notificationService NotificationService) WishlistService {
	return &wishlistService{wishlistRepository: wishlistRepository, notificationService: notificationService}
}

func (s *wishlistService) GetAllWishlist() ([]entity.Wishlist, error) {
	wishlists, err := s.wishlistRepository.GetAllWishlist()
	if err != nil {
		return nil, err
	}
	return wishlists, nil
}

func (s *wishlistService) AddWishlist(wishlist *entity.Wishlist) (*entity.Wishlist, error) {
	// Periksa apakah event dengan event_id dan user_id yang sama sudah ada di wishlist
	existingWishlist, err := s.wishlistRepository.GetWishlistByEventAndUser(wishlist.EventId, wishlist.UserId)
	if err != nil {
		return nil, err
	}

	if existingWishlist != nil {
		return nil, errors.New("event already added to wishlist")
	}

	notification := &entity.Notification{
		UserID:  wishlist.UserId,
		Type:    "Add To Whislist",
		Message: "Add To Whislist successful for event " + wishlist.EventId.String(),
		IsRead:  false,
	}
	err = s.notificationService.CreateNotification(notification)
	if err != nil {
		return nil, err
	}
	// Jika belum ada, tambahkan ke wishlist
	return s.wishlistRepository.AddWishlist(wishlist)
}

func (s *wishlistService) RemoveWishlist(EventId, UserId uuid.UUID) (*entity.Wishlist, error) {
	// Periksa apakah event dengan eventID dan userID yang sama sudah ada di wishlist
	existingWishlist, err := s.wishlistRepository.GetWishlistByEventAndUser(EventId, UserId)
	if err != nil {
		return nil, err
	}

	if existingWishlist == nil {
		return nil, errors.New("wishlist not found for the given event and user")
	}

	// Hapus wishlist
	err = s.wishlistRepository.RemoveWishlist(EventId, UserId)
	if err != nil {
		return nil, err
	}

	return existingWishlist, nil
}
