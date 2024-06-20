package repository

import (
	"encoding/json"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type TicketRepository interface {
	FindAllTicket() ([]entity.Tickets, error)
	FindTicketsByEventID(eventID uuid.UUID) ([]entity.Tickets, error)
}

type ticketRepository struct {
	db        *gorm.DB
	cacheable cache.Cacheable
}

func NewTicketRepository(db *gorm.DB, cacheable cache.Cacheable) *ticketRepository {
	return &ticketRepository{db: db, cacheable: cacheable}
}

func (r *ticketRepository) FindAllTicket() ([]entity.Tickets, error) {
	var tickets []entity.Tickets

	key := "FindAllTicket"

	data, err := r.cacheable.Get(key)
	if err == nil && data != "" {
		err = json.Unmarshal([]byte(data), &tickets)
		if err == nil {
			return tickets, nil
		}
	}

	result := r.db.
		Model(&entity.Tickets{}).
		Joins("JOIN transactions ON transactions.transactions_id = tickets.transaction_id").
		Where("transactions.status = ?", true).
		Find(&tickets)
	if result.Error != nil {
		return nil, result.Error
	}

	marshalledTickets, err := json.Marshal(tickets)
	if err == nil {
		err = r.cacheable.Set(key, marshalledTickets, 5*time.Minute)
	}

	return tickets, err
}

func (r *ticketRepository) FindTicketsByEventID(eventID uuid.UUID) ([]entity.Tickets, error) {
	var tickets []entity.Tickets
	if err := r.db.Where("event_id = ?", eventID).Find(&tickets).Error; err != nil {
		return nil, err
	}
	return tickets, nil
}
