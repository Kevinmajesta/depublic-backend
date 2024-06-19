package entity

import "github.com/google/uuid"

type Cart struct {
	CartId     uuid.UUID `json:"cart_id" gorm:"primaryKey"`
	UserId     uuid.UUID `json:"user_id"`
	User       User      `json:"-" gorm:"foreignkey:user_id"`
	EventId    uuid.UUID `json:"event_id"`
	Event      []Event   `json:"-" gorm:"foreignkey:event_id"`
	Qty        int       `json:"qty" gorm:"default:1"`
	TicketDate string    `json:"ticket_date"`
	Price      int       `json:"price"`
	Auditable
}
