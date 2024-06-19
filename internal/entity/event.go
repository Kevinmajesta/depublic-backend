package entity

import (
	"time"

	"github.com/google/uuid"
)

type Event struct {
	EventID          uuid.UUID       `json:"event_id" gorm:"type:uuid;primary_key"`
	CategoryID       uuid.UUID       `json:"category_id"`
	EventCategories  EventCategories `json:"-" gorm:"foreignkey:category_id"`
	TitleEvent       string          `json:"title_event"`
	DateEvent        time.Time       `json:"date_event"`
	PriceEvent       int             `json:"price_event"`
	CityEvent        string          `json:"city_event"`
	AddressEvent     string          `json:"address_event"`
	QtyEvent         int             `json:"qty_event"`
	DescriptionEvent string          `json:"description_event"`
	Auditable
}
