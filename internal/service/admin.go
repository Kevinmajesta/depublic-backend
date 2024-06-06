package service

import (
	"errors"
	"log" // Import log package
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
)

type AdminService interface {
	LoginAdmin(email string, password string) (string, error)
	FindAllAdmin() ([]map[string]interface{}, error)
}

type adminService struct {
	adminRepository repository.AdminRepository
	tokenUseCase    token.TokenUseCase
}

func NewAdminService(adminRepository repository.AdminRepository, tokenUseCase token.TokenUseCase) *adminService {
	return &adminService{
		adminRepository: adminRepository,
		tokenUseCase:    tokenUseCase,
	}
}

func (s *adminService) LoginAdmin(email string, password string) (string, error) {
	admin, err := s.adminRepository.FindAdminByEmail(email)
	if err != nil {
		log.Println("Error finding admin by email:", err)
		return "", errors.New("email/password yang anda masukkan salah")
	}

	if admin == nil {
		log.Println("Admin is nil")
		return "", errors.New("email/password yang anda masukkan salah")
	}

	if admin.Password != password {
		return "", errors.New("email/password yang anda masukkan salah")
	}
	if admin.Is_admin != "admin" {
		return "", errors.New("bukan admin")
	}
	expiredTime := time.Now().Local().Add(5 * time.Minute)

	claims := token.JwtCustomClaims{
		ID:       admin.ID.String(),
		Email:    admin.Email,
		Is_admin: "admin",
		RegisteredClaims: jwt.RegisteredClaims{
			Issuer:    "Depublic",
			ExpiresAt: jwt.NewNumericDate(expiredTime),
		},
	}

	token, err := s.tokenUseCase.GenerateAccessToken(claims)
	if err != nil {
		return "", errors.New("ada kesalahan dari sistem")
	}
	return token, nil
}

func (s *adminService) FindAllAdmin() ([]map[string]interface{}, error) {
	var users []entity.User
	err := s.adminRepository.FindByRole("admin", &users)
	if err != nil {
		return nil, err
	}

	var response []map[string]interface{}
	for _, admin := range users {
		adminData := map[string]interface{}{
			"id":       admin.ID,
			"email":    admin.Email,
			"password": admin.Password,
		}
		response = append(response, adminData)
	}

	return response, nil
}
