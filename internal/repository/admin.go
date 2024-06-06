package repository

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type AdminRepository interface {
	FindAdminByEmail(email string) (*entity.Admin, error)
	FindAdminByID(id uuid.UUID) (*entity.Admin, error)
	FindByRole(role string, users *[]entity.User) error
}

type adminRepository struct {
	db *gorm.DB
}

func NewAdminRepository(db *gorm.DB) *adminRepository {
	return &adminRepository{db}
}

func (r *adminRepository) FindAdminByID(id uuid.UUID) (*entity.Admin, error) {
	admin := new(entity.Admin)
	if err := r.db.Where("id = ?", id).Take(admin).Error; err != nil {
		return admin, err
	}
	return admin, nil
}

func (r *adminRepository) FindAdminByEmail(email string) (*entity.Admin, error) {
	admin := new(entity.Admin)
	if err := r.db.Where("email = ?", email).Take(admin).Error; err != nil {
		return admin, err
	}
	return admin, nil
}

func (r *adminRepository) FindByRole(role string, users *[]entity.User) error {
	return r.db.Where("is_admin = ?", role).Find(users).Error
}
