package repository

import (
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type EventRepository interface {
	// TODO ADD
	AddEvent(event *entity.Events) (*entity.Events, error)
	// TODO GET
	GetAllEvent() ([]entity.Events, error)
	GetEventByID(eventID uuid.UUID) (*entity.Events, error)
	// TODO UPDATE
	UpdateEvent(event *entity.Events) (*entity.Events, error)
	// TODO DELETE
	DeleteEventByID(eventID uuid.UUID) (*entity.Events, error)
	// TODO SEARCH
	SearchByTitle(title string) ([]entity.Events, error)
	// TODO SORT
	SortEvents(sortBy string) ([]entity.Events, error)
	// TODO FILTER
	FilterEvents(
		categoryID uuid.UUID,
		startDate string,
		endDate string,
		cityEvent string,
		priceMin int,
		priceMax int,
	) ([]entity.Events, error)
}
type eventRepository struct {
	db *gorm.DB
}

func NewEventRepository(db *gorm.DB) EventRepository {
	return &eventRepository{db: db}
}

// TODO ADD EVENT
func (r *eventRepository) AddEvent(event *entity.Events) (*entity.Events, error) {
	query := r.db
	if err := query.Create(&event).Error; err != nil {
		return event, err
	}
	return event, nil
}

// TODO UPDATE EVENT
func (r *eventRepository) UpdateEvent(event *entity.Events) (*entity.Events, error) {
	// Save the updated event
	query := r.db
	if err := query.Save(event).Error; err != nil {
		return nil, err
	}
	return event, nil
}

// UpdateEventByID updates an event by ID in the database.
func (r *eventRepository) UpdateEventByID(eventID uuid.UUID, event *entity.Events) (*entity.Events, error) {
	event.Event_id = eventID
	return r.UpdateEvent(event)
}

// TODO DELETE EVENT BY ID
func (r *eventRepository) DeleteEventByID(eventID uuid.UUID) (*entity.Events, error) {
	// Create a variable to hold the event
	var event entity.Events
	query := r.db
	// Find the event by ID and delete it
	if err := query.Where("event_id = ?", eventID).Unscoped().Delete(&event).Error; err != nil {
		return nil, err
	}

	return &event, nil
}

// TODO GET ALL EVENT
func (r *eventRepository) GetAllEvent() ([]entity.Events, error) {
	var events []entity.Events
	query := r.db
	if err := query.Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}

// GET EVENT BY ID
func (r *eventRepository) GetEventByID(eventID uuid.UUID) (*entity.Events, error) {
	var event entity.Events
	query := r.db
	if err := query.First(&event, "event_id = ?", eventID).Error; err != nil {
		return nil, err
	}
	return &event, nil
}

// Search By Title
//
//	func (r *eventRepository) SearchByTitle(title string) ([]entity.Events, error) {
//		var events []entity.Events
//		if err := r.db.Where("title_event LIKE ?", "%"+title+"%").Find(&events).Error; err != nil {
//			return nil, err
//		}
//		return events, nil
//	}
//
// Updated for Search By Title
func (r *eventRepository) SearchByTitle(title string) ([]entity.Events, error) {
	var events []entity.Events
	query := r.db
	// Gunakan fungsi LOWER untuk mengabaikan perbedaan huruf besar dan kecil
	if err := query.Where("LOWER(title_event) LIKE LOWER(?)", "%"+title+"%").Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}

// TODO Get Events Filtering
func (r *eventRepository) FilterEvents(
	categoryID uuid.UUID,
	startDate string,
	endDate string,
	cityEvent string,
	priceMin int,
	priceMax int,
) ([]entity.Events, error) {
	var events []entity.Events
	query := r.db

	if categoryID != (uuid.UUID{}) {
		query = query.Where("category_id = ?", categoryID)
	}
	if startDate != "" && endDate != "" {
		query = query.Where("date_event BETWEEN ? AND ?", startDate, endDate)
	} else if startDate != "" {
		query = query.Where("date_event >= ?", startDate)
	} else if endDate != "" {
		query = query.Where("date_event <= ?", endDate)
	}
	if cityEvent != "" {
		query = query.Where("LOWER(city_event) LIKE LOWER(?)", "%"+cityEvent+"%")
	}
	if priceMin != 0 {
		query = query.Where("price_event >= ?", priceMin)
	}
	if priceMax != 0 {
		query = query.Where("price_event <= ?", priceMax)
	}

	if err := query.Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}

// TODO SORT
// func (r *eventRepository) SortEvents(sortBy string) ([]entity.Events, error) {
// 	var events []entity.Events
// 	query := r.db

// 	// Apply sorting based on the sortBy parameter
// 	switch sortBy {
// 	case "terbaru":
// 		query = query.Find(&events).Order("created_at DESC")
// 	case "termahal":
// 		query = query.Find(&events).Order("price_event DESC")
// 	case "termurah":
// 		query = query.Find(&events).Order("price_event ASC")
// 	default:
// 		// Default sorting if sort_by is not recognized
// 		query = query.Find(&events).Order("date_event DESC")
// 	}

// 	if err := query.Find(&events).Error; err != nil {
// 		return nil, err
// 	}
// 	return events, nil
// }

func (r *eventRepository) SortEvents(sortBy string) ([]entity.Events, error) {
	var events []entity.Events
	query := r.db

	// Apply sorting based on the sortBy parameter
	switch sortBy {
	case "terbaru":
		query = query.Order("created_at DESC")
	case "termahal":
		query = query.Order("price_event DESC")
	case "termurah":
		query = query.Order("price_event ASC")
	case "terdekat":
		query = query.Order("date_event ASC").Where("date_event >= ?", time.Now().Format("200-01-01"))
	default:
		// Default sorting if sort_by is not recognized
		query = query.Order("date_event DESC")
	}

	if err := query.Find(&events).Error; err != nil {
		return nil, err
	}
	return events, nil
}
