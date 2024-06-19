package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/google/uuid"
)

type EventService interface {
	// TODO POST
	AddEvent(event *entity.Event) (*entity.Event, error)
	// TODO UPDATE
	UpdateEvent(event *entity.Event) (*entity.Event, error)
	// UpdateEventByID(eventID uuid.UUID, event *entity.Event) (*entity.Event, error)
	// TODO DELETE
	DeleteEventByID(eventID uuid.UUID) (*entity.Event, error)
	// TODO GET
	GetAllEvent() ([]entity.Event, error)
	GetEventByID(eventID uuid.UUID) (*entity.Event, error)
	SearchEventsByTitle(title string) ([]entity.Event, error)
	// TODO Filtering Events
	FilterEvents(
		categoryID *uuid.UUID,
		startDate *string,
		endDate *string,
		cityEvent *string,
		priceMin *int,
		priceMax *int,
	) ([]entity.Event, error)
}

type eventService struct {
	eventRepo repository.EventRepository
	// categoryService CategoryService
}

func NewEventService(eventRepo repository.EventRepository) EventService {
	return &eventService{eventRepo: eventRepo}
}

func (s *eventService) AddEvent(event *entity.Event) (*entity.Event, error) {
	return s.eventRepo.AddEvent(event)
}

func (s *eventService) UpdateEvent(event *entity.Event) (*entity.Event, error) {
	return s.eventRepo.UpdateEvent(event)
}

// UpdateEventByID updates an event by ID.
//
//	func (s *eventService) UpdateEventByID(eventID uuid.UUID, event *entity.Event) (*entity.Event, error) {
//		return s.eventRepo.UpdateEventByID(eventID, event)
//	}
func (s *eventService) DeleteEventByID(eventID uuid.UUID) (*entity.Event, error) {
	return s.eventRepo.DeleteEventByID(eventID)
}

func (s *eventService) GetAllEvent() ([]entity.Event, error) {
	return s.eventRepo.GetAllEvent()
}

func (s *eventService) GetEventByID(eventID uuid.UUID) (*entity.Event, error) {
	return s.eventRepo.GetEventByID(eventID)
}

func (s *eventService) SearchEventsByTitle(title string) ([]entity.Event, error) {
	return s.eventRepo.SearchByTitle(title)
}

// Filtering Event
func (s *eventService) FilterEvents(
	categoryID *uuid.UUID,
	startDate *string,
	endDate *string,
	cityEvent *string,
	priceMin *int,
	priceMax *int,
) ([]entity.Event, error) {
	return s.eventRepo.FilterEvents(categoryID, startDate, endDate, cityEvent, priceMin, priceMax)
}
