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
	FindTicketsByQRCode(QRCode uuid.UUID) ([]entity.Tickets, error)
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

func (s *ticketService) FindTicketsByQRCode(QRCode uuid.UUID) ([]entity.Tickets, error) {
	tickets, err := s.ticketRepository.FindTicketsByQRCode(QRCode)
	if err != nil {
		return nil, err
	}
	return tickets, nil
}
