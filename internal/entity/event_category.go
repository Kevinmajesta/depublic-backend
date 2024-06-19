package entity

import "github.com/google/uuid"

type EventCategories struct {
	EventCategoryID uuid.UUID `json:"event_categories_id" gorm:"primaryKey"`
	NameCategories  string    `json:"name_categories"`
	Auditable
}
