package repository

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"gorm.io/gorm"
)

type PaymentRepository interface {
	CreatePayment(payment *entity.Payments) (*entity.Payments, error)
	CreatePaymentdata(pay_id, trx_id, status, trx_time, trx_sett_time, pay_type, signature_key string) (*entity.Payments, error)
}

type paymentRepository struct {
	db        *gorm.DB
	cacheable cache.Cacheable
}

func NewPaymentRepository(db *gorm.DB, cacheable cache.Cacheable) PaymentRepository {
	return &paymentRepository{db: db, cacheable: cacheable}
}

func (r *paymentRepository) CreatePayment(payment *entity.Payments) (*entity.Payments, error) {

	if err := r.db.Create(&payment).Error; err != nil {
		return payment, err
	}
	return payment, nil

}

func (r *paymentRepository) CreatePaymentdata(pay_id, trx_id, status, trx_time, trx_sett_time, pay_type, signature_key string) (*entity.Payments, error) {
	if r.db == nil {
		// return fmt.Errorf("database connection is nil")
	}

	payment := entity.Payments{Payment_id: pay_id, Transaksi_id: trx_id, Status_pay: status, Pay_time: trx_time, Pay_settlement_time: trx_sett_time, Pay_type: pay_type, Signature_key: signature_key}
	if err := r.db.Create(&payment).Error; err != nil {
		return &payment, err
	}

	return &payment, nil
}
