package service

import (
	"errors"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/Kevinmajesta/depublic-backend/pkg/token"
	"github.com/golang-jwt/jwt/v5"
)

type UserService interface {
	LoginUser(email string, password string) (string, error)
	FindAllUser() ([]map[string]interface{}, error)
}

type userService struct {
	userRepository repository.UserRepository
	tokenUseCase   token.TokenUseCase
}

func NewUserService(userRepository repository.UserRepository, tokenUseCase token.TokenUseCase) *userService {
	return &userService{
		userRepository: userRepository,
		tokenUseCase:   tokenUseCase,
	}
}

func (s *userService) LoginUser(email string, password string) (string, error) {
	user, err := s.userRepository.FindUserByEmail(email)
	if err != nil {
		return "", errors.New("email/password yang anda masukkan salah")
	}

	if user.Password != password {
		return "", errors.New("email/password yang anda masukkan salah")
	}
	if user.Is_admin != "user" {
		return "", errors.New("bukan user")
	}
	expiredTime := time.Now().Local().Add(5 * time.Minute)

	claims := token.JwtCustomClaims{
		ID:       user.ID.String(),
		Email:    user.Email,
		Is_admin: "user",
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

func (s *userService) FindAllUser() ([]map[string]interface{}, error) {
	var users []entity.User
	err := s.userRepository.FindByRole("user", &users)
	if err != nil {
		return nil, err
	}
	var response []map[string]interface{}
	for _, user := range users {
		userData := map[string]interface{}{
			"id":       user.ID,
			"fullname": user.Fullname,
			"email":    user.Email,
			"password": user.Password,
			"status":   user.Status,
		}
		response = append(response, userData)
	}

	return response, nil
}
