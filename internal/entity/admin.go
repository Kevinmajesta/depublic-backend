package entity

import (
	"github.com/google/uuid"
)

type Admin struct {
	ID       uuid.UUID `json:"id"`
	Email    string    `json:"email"`
	Password string    `json:"password"`
	Is_admin string    `json:"is_admin"`
	Auditable
	Verification string `json:"verification"`
}

func NewAdmin(email, password, role string) *Admin {
	return &Admin{
		ID:        uuid.New(),
		Email:     email,
		Password:  password,
		Auditable: NewAuditable(),
	}
}

func UpdateAdmin(id uuid.UUID, email, password, role string) *Admin {
	return &Admin{
		ID:        id,
		Email:     email,
		Password:  password,
		Auditable: UpdateAuditable(),
	}
}

func (Admin) TableName() string {
	return "users"
}
