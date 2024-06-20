package entity

import "github.com/google/uuid"

type EventCategories struct {
	EventCategoryID uuid.UUID `json:"event_categories_id" gorm:"primaryKey"`
	NameCategories  string    `json:"name_categories" gorm:"not null"`
	Auditable
}

func NewCategory(name_categories string) *EventCategories {
	return &EventCategories{
		EventCategoryID: uuid.New(),
		NameCategories:  name_categories,
		Auditable:       NewAuditable(),
	}
}

func UpdateCategory(event_categories_id uuid.UUID, name_categories string) *EventCategories {
	return &EventCategories{
		EventCategoryID: event_categories_id,
		NameCategories:  name_categories,
		Auditable:       UpdateAuditable(),
	}
}
