package service

import (
	"errors"
	"log" // Import log package
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/encrypt"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type AdminService interface {
	LoginAdmin(email string, password string) (string, error)
	FindAllUser() ([]entity.User, error)
	CreateAdmin(admin *entity.Admin) (*entity.Admin, error)
	UpdateAdmin(admin *entity.Admin) (*entity.Admin, error)
	DeleteAdmin(admin uuid.UUID) (bool, error)
	EmailExists(email string) bool
}

type adminService struct {
	adminRepository repository.AdminRepository
	tokenUseCase    token.TokenUseCase
	encryptTool     encrypt.EncryptTool
}

func NewAdminService(adminRepository repository.AdminRepository, tokenUseCase token.TokenUseCase, encryptTool encrypt.EncryptTool) *adminService {
	return &adminService{
		adminRepository: adminRepository,
		tokenUseCase:    tokenUseCase,
		encryptTool:     encryptTool,
	}
}

func (s *adminService) LoginAdmin(email string, password string) (string, error) {
	admin, err := s.adminRepository.FindAdminByEmail(email)
	if err != nil {
		log.Println("Error finding admin by email:", err)
		return "", errors.New("email/password yang anda masukkan salah")
	}
	if admin.Role != "admin" {
		return "", errors.New("anda bukan admin")
	}

	// Debugging: log hash kata sandi dari database
	log.Printf("Hashed password from database: %s", admin.Password)

	err = bcrypt.CompareHashAndPassword([]byte(admin.Password), []byte(password))
	if err != nil {
		// Debugging: log kesalahan yang dikembalikan oleh bcrypt
		log.Printf("Password comparison error: %v", err)
		return "", errors.New("email/password yang anda masukkan salah")
	}

	// Lanjutkan dengan pembuatan token dan logika lainnya
	expiredTime := time.Now().Local().Add(5 * time.Minute)

	claims := token.JwtCustomClaims{
		ID:    admin.User_ID.String(),
		Email: admin.Email,
		Role:  "admin",
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

func (s *adminService) FindAllUser() ([]entity.User, error) {
	admin, err := s.adminRepository.FindAllUser()
	if err != nil {
		return nil, err
	}

	formattedAdmin := make([]entity.User, 0)
	for _, v := range admin {
		v.Phone, _ = s.encryptTool.Decrypt(v.Phone)
		formattedAdmin = append(formattedAdmin, v)
	}

	return formattedAdmin, nil
}

func (s *adminService) CreateAdmin(admin *entity.Admin) (*entity.Admin, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(admin.Password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}
	admin.Password = string(hashedPassword)

	newAdmin, err := s.adminRepository.CreateAdmin(admin)
	if err != nil {
		return nil, err
	}

	return newAdmin, nil
}

func (s *adminService) UpdateAdmin(admin *entity.Admin) (*entity.Admin, error) {
	if admin.Password != "" {
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(admin.Password), bcrypt.DefaultCost)
		if err != nil {
			return nil, err
		}
		admin.Password = string(hashedPassword)
	}
	if admin.Phone != "" {
		admin.Phone, _ = s.encryptTool.Encrypt(admin.Phone)
	}
	return s.adminRepository.UpdateAdmin(admin)
}

func (s *adminService) DeleteAdmin(user_Id uuid.UUID) (bool, error) {
	user, err := s.adminRepository.FindAdminByID(user_Id)
	if err != nil {
		return false, err
	}

	return s.adminRepository.DeleteAdmin(user)
}

func (s *adminService) EmailExists(email string) bool {
	_, err := s.adminRepository.FindAdminByEmail(email)
	if err != nil {
		return false
	}
	return true
}
