package entity

import (
	"github.com/google/uuid"
)

type User struct {
	ID       uuid.UUID `json:"id"`
	Fullname string    `json:"fullname"`
	Email    string    `json:"email"`
	Password string    `json:"password"`
	Phone    string    `json:"phone"`
	Is_admin string    `json:"is_admin"`
	Status   string    `json:"status"`
	Auditable
	Verification string `json:"verification_code"`
}

func NewUser(fullname, email, password, phone, is_admin string) *User {
	return &User{
		ID:        uuid.New(),
		Fullname:  fullname,
		Email:     email,
		Password:  password,
		Phone:     phone,
		Is_admin:  is_admin,
		Auditable: NewAuditable(),
	}
}

func UpdateUser(id uuid.UUID, fullname, email, password, phone, is_admin string) *User {
	return &User{
		ID:        id,
		Fullname:  fullname,
		Email:     email,
		Password:  password,
		Phone:     phone,
		Is_admin:  is_admin,
		Auditable: UpdateAuditable(),
	}
}
