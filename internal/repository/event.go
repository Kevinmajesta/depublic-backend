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
// func (r *eventRepository) UpdateEvent(event *entity.Event) (*entity.Event, error) {
// 	var existingEvent entity.Event
// 	if err := r.db.First(&existingEvent, "event_id = ?", event.EventID).Error; err != nil {
// 		return nil, err
// 	}

// 	existingEvent.CategoryID = event.CategoryID
// 	existingEvent.TitleEvent = event.TitleEvent
// 	existingEvent.DateEvent = event.DateEvent
// 	existingEvent.PriceEvent = event.PriceEvent
// 	existingEvent.CityEvent = event.CityEvent
// 	existingEvent.AddressEvent = event.AddressEvent
// 	existingEvent.QtyEvent = event.QtyEvent
// 	existingEvent.DescriptionEvent = event.DescriptionEvent
// 	existingEvent.ImageURL = event.ImageURL

// 	if err := r.db.Save(&existingEvent).Error; err != nil {
// 		return nil, err
// 	}

// 	return &existingEvent, nil
// }

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
