package entity

import (
	"github.com/google/uuid"
)

type EventCategory struct {
	EventCategoriesID uuid.UUID `json:"event_categories_id" gorm:"primaryKey"`
	NameCategories    string    `json:"name_categories" gorm:"not null"`
	Auditable
}

func NewCategory(name_categories string) *EventCategory {
	return &EventCategory{
		EventCategoriesID: uuid.New(),
		NameCategories:    name_categories,
		Auditable:         NewAuditable(),
	}
}

func UpdateCategory(event_categories_id uuid.UUID, name_categories string) *EventCategory {
	return &EventCategory{
		EventCategoriesID: event_categories_id,
		NameCategories:    name_categories,
		Auditable:         UpdateAuditable(),
	}
}
