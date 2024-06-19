package repository

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type EventRepository interface {
	CheckEvent(EventId uuid.UUID) error
	CheckQtyEvent(EventId uuid.UUID) (int, error)
	CheckPriceEvent(EventId uuid.UUID) (int, error)
	IncreaseEventStock(EventId uuid.UUID, qty int) error
	DecreaseEventStock(EventId uuid.UUID, qty int) error
	CheckDateEvent(EventId uuid.UUID) (string, error)
}

type eventRepository struct {
	db *gorm.DB
}

func NewEventRepository(db *gorm.DB) EventRepository {
	return &eventRepository{db: db}
}

func (r *eventRepository) CheckEvent(EventId uuid.UUID) error {
	if err := r.db.Find("events").Error; err != nil {
		return err
	}

	return nil
}

func (r *eventRepository) CheckQtyEvent(EventId uuid.UUID) (int, error) {
	var qty int

	if err := r.db.Raw("SELECT qty_event FROM events WHERE event_id = ?", EventId).Scan(&qty).Error; err != nil {
		return 0, err
	}

	return qty, nil
}

func (r *eventRepository) CheckPriceEvent(EventId uuid.UUID) (int, error) {
	var price int

	if err := r.db.Raw("SELECT price_event FROM events WHERE event_id = ?", EventId).Scan(&price).Error; err != nil {
		return 0, err
	}

	return price, nil
}

func (r *eventRepository) IncreaseEventStock(EventId uuid.UUID, QtyEvent int) error {
	err := r.db.Exec("UPDATE events SET qty_event = qty_event + ? WHERE event_id = ?", QtyEvent, EventId).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *eventRepository) DecreaseEventStock(EventId uuid.UUID, Qty int) error {
	err := r.db.Exec("UPDATE events SET qty_event = qty_event - ? WHERE event_id = ?", Qty, EventId).Error
	if err != nil {
		return err
	}
	return nil
}

func (r *eventRepository) CheckDateEvent(EventId uuid.UUID) (string, error) {
	var date string

	if err := r.db.Raw("SELECT date_event FROM events WHERE event_id = ?", EventId).Scan(&date).Error; err != nil {
		return "", err
	}

	return date, nil
}
