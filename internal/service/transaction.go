package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/google/uuid"
)

type TransactionService interface {
	CreateTransaction(transaction *entity.Transactions) (*entity.Transactions, error)
	CreateTransactiondetail(transaction *entity.Transaction_details) (*entity.Transaction_details, error)
	FindTrxrelationadminByID(User_id uuid.UUID) ([]entity.Transactions, error)
	CreateTicket(transaction *entity.Tickets) (*entity.Tickets, error)
	FindAllTransaction() ([]entity.Transactions, error)
	FindEventByID(Event_id uuid.UUID) (*entity.Events, error)
	FindCartByID(cart_id uuid.UUID) (*entity.Carts, error)
	FindUserByID(User_idd uuid.UUID) (*entity.Useraccount, error)
	FindTrxByID(Transaction_id uuid.UUID) (*entity.Transactions, error)
	FindTrxrelationByID(Transaction_id uuid.UUID, User_id uuid.UUID) (*entity.Transactions, error)
	FindTrxdetailByID(Transaction_id uuid.UUID) (*entity.Transaction_details, error)
	UpdateTransaction(transactionupdate *entity.Transactions) (*entity.Transactions, error)
}

type transactionService struct {
	transactionRepository repository.TransactionRepository
}

func NewTransactionService(transactionRepo repository.TransactionRepository) TransactionService {
	return &transactionService{transactionRepository: transactionRepo}
}

func (s *transactionService) CreateTransaction(transaction *entity.Transactions) (*entity.Transactions, error) {
	return s.transactionRepository.CreateTransaction(transaction)
}

func (s *transactionService) CreateTransactiondetail(transactiondetail *entity.Transaction_details) (*entity.Transaction_details, error) {
	return s.transactionRepository.CreateTransactiondetail(transactiondetail)
}

func (s *transactionService) CreateTicket(ticket *entity.Tickets) (*entity.Tickets, error) {
	return s.transactionRepository.CreateTicket(ticket)
}

func (s *transactionService) FindAllTransaction() ([]entity.Transactions, error) {
	transaction, err := s.transactionRepository.FindAllTransaction()
	if err != nil {
		return nil, err
	}

	formattedTransacion := make([]entity.Transactions, 0)
	for _, v := range transaction {
		formattedTransacion = append(formattedTransacion, v)
	}

	return formattedTransacion, nil
}

func (s *transactionService) FindEventByID(Event_id uuid.UUID) (*entity.Events, error) {
	return s.transactionRepository.FindEventByID(Event_id)
}

func (s *transactionService) FindTrxByID(Transaction_id uuid.UUID) (*entity.Transactions, error) {
	return s.transactionRepository.FindTrxByID(Transaction_id)
}
func (s *transactionService) FindTrxrelationByID(Transaction_id uuid.UUID, User_id uuid.UUID) (*entity.Transactions, error) {
	return s.transactionRepository.FindTrxrelationByID(Transaction_id, User_id)
}

func (s *transactionService) FindTrxrelationadminByID(User_id uuid.UUID) ([]entity.Transactions, error) {
	return s.transactionRepository.FindTrxrelationadminByID(User_id)
}

func (s *transactionService) FindTrxdetailByID(Transaction_id uuid.UUID) (*entity.Transaction_details, error) {
	return s.transactionRepository.FindTrxdetailByID(Transaction_id)
}

func (s *transactionService) FindCartByID(Cart_id uuid.UUID) (*entity.Carts, error) {
	return s.transactionRepository.FindCartByID(Cart_id)
}

func (s *transactionService) FindUserByID(User_id uuid.UUID) (*entity.Useraccount, error) {
	return s.transactionRepository.FindUserByID(User_id)
}

func (s *transactionService) UpdateTransaction(transactionupdate *entity.Transactions) (*entity.Transactions, error) {
	if transactionupdate.Status != "" {

		transactionupdate.Status = "true"
	}
	return s.transactionRepository.UpdateTransaction(transactionupdate)
}
