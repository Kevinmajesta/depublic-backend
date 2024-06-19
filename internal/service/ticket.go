package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/google/uuid"
)

type TicketService interface {
	FindAllTicket() ([]entity.Ticket, error)
	FindTicketsByEventID(eventID uuid.UUID) ([]entity.Ticket, error)
	CreateTicket(ticket *entity.Ticket) (*entity.Ticket, error) // Fungsi baru untuk membuat tiket
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

func (s *ticketService) FindAllTicket() ([]entity.Ticket, error) {
	return s.ticketRepository.FindAllTicket()
}

func (s *ticketService) FindTicketsByEventID(eventID uuid.UUID) ([]entity.Ticket, error) {
	tickets, err := s.ticketRepository.FindTicketsByEventID(eventID)
	if err != nil {
		return nil, err
	}
	return tickets, nil
}

func (s *ticketService) CreateTicket(ticket *entity.Ticket) (*entity.Ticket, error) {
	return s.ticketRepository.CreateTicket(ticket)
}
