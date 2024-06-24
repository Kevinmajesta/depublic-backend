package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
)

type PaymentService interface {
	CreatePayment(payment *entity.Payments) (*entity.Payments, error)
	CreatePaymentdata(pay_id, trx_id, status, trx_time, trx_sett_time, pay_type, signature_key string) (*entity.Payments, error)
}

type paymentService struct {
	paymentRepository repository.PaymentRepository
}

func NewPaymentService(paymentRepo repository.PaymentRepository) PaymentService {
	return &paymentService{paymentRepository: paymentRepo}
}

func (s *paymentService) CreatePayment(payment *entity.Payments) (*entity.Payments, error) {
	return s.paymentRepository.CreatePayment(payment)
}

func (s *paymentService) CreatePaymentdata(pay_id, trx_id, status, trx_time, trx_sett_time, pay_type, signature_key string) (*entity.Payments, error) {
	return s.paymentRepository.CreatePaymentdata(pay_id, trx_id, status, trx_time, trx_sett_time, pay_type, signature_key)
}

// func (s *paymentService) CreatePaymentdata(payID string) error {

// 	payment := Payment{PayID: payID}
// 	result := s.DB.Create(&payment)
// 	return result.Error
// }
