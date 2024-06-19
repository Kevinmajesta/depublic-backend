package repository

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type EventRepository interface {
	AddEvent(event *entity.Event) (*entity.Event, error)
	GetAllEvent() ([]entity.Event, error)
	UpdateEvent(event *entity.Event) (*entity.Event, error)
	DeleteEventByID(eventID uuid.UUID) (*entity.Event, error)
	GetEventByID(eventID uuid.UUID) (*entity.Event, error)
	SearchByTitle(title string) ([]entity.Event, error)
	// GetEventsByCategoryID(categoryID uuid.UUID) ([]entity.Event, error)
	// Filter
	FilterEvents(
		categoryID *uuid.UUID,
		dateEvent *string,
		dateEventR *string,
		cityEvent *string,
		priceMin *int,
		priceMax *int,
	) ([]entity.Event, error)
}

type eventRepository struct {
	db *gorm.DB
}

func NewEventRepository(db *gorm.DB) EventRepository {
	return &eventRepository{db: db}
}

// TODO ADD EVENT
func (r *eventRepository) AddEvent(event *entity.Event) (*entity.Event, error) {
	if err := r.db.Create(&event).Error; err != nil {
		return event, err
	}
	return event, nil
}

// TODO UPDATE EVENT
func (r *eventRepository) UpdateEvent(event *entity.Event) (*entity.Event, error) {
	// Save the updated event
	if err := r.db.Save(event).Error; err != nil {
		return nil, err
	}
	return event, nil
}

// UpdateEventByID updates an event by ID in the database.
func (r *eventRepository) UpdateEventByID(eventID uuid.UUID, event *entity.Event) (*entity.Event, error) {
	event.EventID = eventID
	return r.UpdateEvent(event)
}

// TODO DELETE EVENT BY ID
func (r *eventRepository) DeleteEventByID(eventID uuid.UUID) (*entity.Event, error) {
	// Create a variable to hold the event
	var event entity.Event

	// Find the event by ID and delete it
	if err := r.db.Where("event_id = ?", eventID).Unscoped().Delete(&event).Error; err != nil {
		return nil, err
	}

	return &event, nil
}

// TODO GET ALL EVENT
func (r *eventRepository) GetAllEvent() ([]entity.Event, error) {
	var events []entity.Event
	if err := r.db.Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}

// GET EVENT BY ID
func (r *eventRepository) GetEventByID(eventID uuid.UUID) (*entity.Event, error) {
	var event entity.Event
	if err := r.db.First(&event, "event_id = ?", eventID).Error; err != nil {
		return nil, err
	}
	return &event, nil
}

// Search By Title
//
//	func (r *eventRepository) SearchByTitle(title string) ([]entity.Event, error) {
//		var events []entity.Event
//		if err := r.db.Where("title_event LIKE ?", "%"+title+"%").Find(&events).Error; err != nil {
//			return nil, err
//		}
//		return events, nil
//	}
//
// Updated for Search By Title
func (r *eventRepository) SearchByTitle(title string) ([]entity.Event, error) {
	var events []entity.Event
	// Gunakan fungsi LOWER untuk mengabaikan perbedaan huruf besar dan kecil
	if err := r.db.Where("LOWER(title_event) LIKE LOWER(?)", "%"+title+"%").Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}

// TODO Get Events Filtering
func (r *eventRepository) FilterEvents(
	categoryID *uuid.UUID,
	startDate *string,
	endDate *string,
	cityEvent *string,
	priceMin *int,
	priceMax *int,
) ([]entity.Event, error) {
	var events []entity.Event
	query := r.db

	if categoryID != nil {
		query = query.Where("category_id = ?", *categoryID)
	}
	if startDate != nil && endDate != nil {
		query = query.Where("date_event BETWEEN ? AND ?", *startDate, *endDate)
	} else if startDate != nil {
		query = query.Where("date_event >= ?", *startDate)
	} else if endDate != nil {
		query = query.Where("date_event <= ?", *endDate)
	}
	if cityEvent != nil {
		query = query.Where("LOWER(city_event) = LOWER(?)", *cityEvent)
	}
	if priceMin != nil {
		query = query.Where("price_event >= ?", *priceMin)
	}
	if priceMax != nil {
		query = query.Where("price_event <= ?", *priceMax)
	}

	if err := query.Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}
