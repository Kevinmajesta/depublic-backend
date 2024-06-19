package repository

import (
	"encoding/base64"
	"encoding/json"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/google/uuid"
	"github.com/skip2/go-qrcode"
	"gorm.io/gorm"
)

type TicketRepository interface {
	FindAllTicket() ([]entity.Ticket, error)
	FindTicketsByEventID(eventID uuid.UUID) ([]entity.Ticket, error)
	CreateTicket(ticket *entity.Ticket) (*entity.Ticket, error) // Fungsi baru untuk membuat tiket
}

type ticketRepository struct {
	db        *gorm.DB
	cacheable cache.Cacheable
}

func NewTicketRepository(db *gorm.DB, cacheable cache.Cacheable) *ticketRepository {
	return &ticketRepository{db: db, cacheable: cacheable}
}

func (r *ticketRepository) FindAllTicket() ([]entity.Ticket, error) {
	var tickets []entity.Ticket

	key := "FindAllTicket"

	data, err := r.cacheable.Get(key)
	if err == nil && data != "" {
		err = json.Unmarshal([]byte(data), &tickets)
		if err == nil {
			return tickets, nil
		}
	}

	result := r.db.
		Model(&entity.Ticket{}).
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

func (r *ticketRepository) FindTicketsByEventID(eventID uuid.UUID) ([]entity.Ticket, error) {
	var tickets []entity.Ticket
	if err := r.db.Where("event_id = ?", eventID).Find(&tickets).Error; err != nil {
		return nil, err
	}
	return tickets, nil
}

func (r *ticketRepository) CreateTicket(ticket *entity.Ticket) (*entity.Ticket, error) {
	data := "http://localhost:8080/app/api/v1/ticket/" + ticket.Tickets_ID.String()

	// Generate QR code
	qrCode, err := qrcode.Encode(data, qrcode.Medium, 256)
	if err != nil {
		return nil, err
	}

	// Convert QR code to base64 string
	ticket.Code_QR = base64.StdEncoding.EncodeToString(qrCode)

	// Save ticket to database
	if err := r.db.Create(ticket).Error; err != nil {
		return nil, err
	}

	return ticket, nil
}
