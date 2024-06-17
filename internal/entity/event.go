package entity

import (
	"time"

	"github.com/google/uuid"
)

type Event struct {
	EventID          uuid.UUID     `json:"event_id" gorm:"type:uuid;primary_key"`
	CategoryID       uuid.UUID     `json:"category_id"`
	EventCategories  EventCategory `json:"-" gorm:"foreignkey:category_id"`
	TitleEvent       string        `json:"title_event"`
	DateEvent        string        `json:"date_event"`
	PriceEvent       int           `json:"price_event"`
	CityEvent        string        `json:"city_event"`
	AddressEvent     string        `json:"address_event"`
	QtyEvent         int           `json:"qty_event"`
	DescriptionEvent string        `json:"description_event"`
	ImageURL         string        `json:"image_url"`
	Auditable
}

func NewEvent(
	categoryID uuid.UUID,
	titleEvent string,
	dateEvent string,
	priceEvent int,
	cityEvent string,
	addressEvent string,
	qtyEvent int,
	descriptionEvent string,
	imageURL string,
) *Event {
	return &Event{
		EventID:          uuid.New(),
		CategoryID:       categoryID,
		TitleEvent:       titleEvent,
		DateEvent:        dateEvent,
		PriceEvent:       priceEvent,
		CityEvent:        cityEvent,
		AddressEvent:     addressEvent,
		QtyEvent:         qtyEvent,
		DescriptionEvent: descriptionEvent,
		ImageURL:         imageURL,
		Auditable:        NewAuditable(),
	}
}

func UpdateEvent(
	event *Event,
	categoryID uuid.UUID,
	titleEvent string,
	dateEvent time.Time,
	priceEvent int,
	cityEvent string,
	addressEvent string,
	qtyEvent int,
	descriptionEvent string,
	imageURL string,
) *Event {
	event.CategoryID = categoryID
	event.TitleEvent = titleEvent
	event.DateEvent = dateEvent.Format("2000-01-01")
	event.PriceEvent = priceEvent
	event.CityEvent = cityEvent
	event.AddressEvent = addressEvent
	event.QtyEvent = qtyEvent
	event.DescriptionEvent = descriptionEvent
	if imageURL != "" {
		event.ImageURL = imageURL
	}
	event.Auditable = UpdateAuditable()
	return event
}
