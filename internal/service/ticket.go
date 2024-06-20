package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/google/uuid"
)

type TicketService interface {
	FindAllTicket() ([]entity.Tickets, error)
	FindTicketsByEventID(eventID uuid.UUID) ([]entity.Tickets, error)
	CreateTicket(ticket *entity.Tickets) (*entity.Tickets, error) // Fungsi baru untuk membuat tiket
}

type ticketService struct {
	ticketRepository repository.TicketRepository
	tokenUseCase     token.TokenUseCase
}

func NewTicketService(ticketRepository repository.TicketRepository, tokenUseCase token.TokenUseCase) *ticketService {
	return &ticketService{
		ticketRepository: ticketRepository,
		tokenUseCase:     tokenUseCase,
	}
}

func (s *ticketService) FindAllTicket() ([]entity.Tickets, error) {
	return s.ticketRepository.FindAllTicket()
}

func (s *ticketService) FindTicketsByEventID(eventID uuid.UUID) ([]entity.Tickets, error) {
	tickets, err := s.ticketRepository.FindTicketsByEventID(eventID)
	if err != nil {
		return nil, err
	}
	return tickets, nil
}
