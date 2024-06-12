package service

import (
	"errors"
	"log"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/encrypt"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type UserService interface {
	LoginUser(email string, password string) (string, error)
	CreateUser(user *entity.User) (*entity.User, error)
	UpdateUser(user *entity.User) (*entity.User, error)
	DeleteUser(user_id uuid.UUID) (bool, error)
	ResetPassword(userID uuid.UUID, newPassword string) error
	EmailExists(email string) bool
	GetUserProfileByID(userID string) (*entity.User, error)
}

type userService struct {
	userRepository repository.UserRepository
	tokenUseCase   token.TokenUseCase
	encryptTool    encrypt.EncryptTool
}

func NewUserService(userRepository repository.UserRepository, tokenUseCase token.TokenUseCase, encryptTool encrypt.EncryptTool) *userService {
	return &userService{
		userRepository: userRepository,
		tokenUseCase:   tokenUseCase,
		encryptTool:    encryptTool,
	}
}

func (s *userService) LoginUser(email string, password string) (string, error) {
	user, err := s.userRepository.FindUserByEmail(email)
	if err != nil {
		return "", errors.New("email/password yang anda masukkan salah")
	}
	if user.Role != "user" {
		return "", errors.New("anda bukan user")
	}

	log.Printf("Hashed password from database: %s", user.Password)
	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password))
	if err != nil {
		// Debugging: log kesalahan yang dikembalikan oleh bcrypt
		log.Printf("Password comparison error: %v", err)
		return "", errors.New("email/password yang anda masukkan salah")
	}

	// Lanjutkan dengan pembuatan token dan logika lainnya
	expiredTime := time.Now().Local().Add(5 * time.Minute)

	user.Phone, _ = s.encryptTool.Decrypt(user.Phone)

	claims := token.JwtCustomClaims{
		ID:    user.User_ID.String(),
		Email: user.Email,
		Role:  "user",
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

func (s *userService) CreateUser(user *entity.User) (*entity.User, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}
	user.Password = string(hashedPassword)

	user.Phone, _ = s.encryptTool.Encrypt(user.Phone)

	newUser, err := s.userRepository.CreateUser(user)
	if err != nil {
		return nil, err
	}

	newUser.Phone, _ = s.encryptTool.Decrypt(newUser.Phone)

	return newUser, nil
}

func (s *userService) UpdateUser(user *entity.User) (*entity.User, error) {
	if user.Password != "" {
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
		if err != nil {
			return nil, err
		}
		user.Password = string(hashedPassword)
	}
	if user.Phone != "" {
		user.Phone, _ = s.encryptTool.Encrypt(user.Phone)
	}
	return s.userRepository.UpdateUser(user)
}

func (s *userService) DeleteUser(user_Id uuid.UUID) (bool, error) {
	user, err := s.userRepository.FindUserByID(user_Id)
	if err != nil {
		return false, err
	}

	return s.userRepository.DeleteUser(user)
}

func (s *userService) ResetPassword(userID uuid.UUID, newPassword string) error {
	// Cari pengguna berdasarkan ID pengguna
	user, err := s.userRepository.FindUserByID(userID)
	if err != nil {
		return err
	}
	if user == nil {
		return errors.New("pengguna tidak ditemukan")
	}

	// Setel kata sandi baru
	user.Password = newPassword

	// Simpan perubahan ke database
	_, err = s.userRepository.UpdateUser(user)
	if err != nil {
		return err
	}

	return nil
}

func (s *userService) EmailExists(email string) bool {
	_, err := s.userRepository.FindUserByEmail(email)
	if err != nil {
		return false
	}
	return true
}

func (s *userService) GetUserProfileByID(userID string) (*entity.User, error) {
	// Konversi userID menjadi uuid.UUID
	userIDUUID, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}

	// Panggil metode dari userRepository untuk mencari profil pengguna berdasarkan ID
	user, err := s.userRepository.FindUserByID(userIDUUID)
	if err != nil {
		return nil, err
	}
	return user, nil
}
