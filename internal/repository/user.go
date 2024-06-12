package repository

import (
	"encoding/json"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/pkg/cache"
	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

type UserRepository interface {
	FindUserByID(id uuid.UUID) (*entity.User, error)
	FindUserByEmail(email string) (*entity.User, error)
	FindByRole(role string, users *[]entity.User) error
	CreateUser(user *entity.User) (*entity.User, error)
	UpdateUser(user *entity.User) (*entity.User, error)
	DeleteUser(user *entity.User) (bool, error)
	GetUserProfileByID(id uuid.UUID) (*entity.User, error)
}

type userRepository struct {
	db        *gorm.DB
	cacheable cache.Cacheable
}

func NewUserRepository(db *gorm.DB, cacheable cache.Cacheable) *userRepository {
	return &userRepository{db: db, cacheable: cacheable}
}

func (r *userRepository) FindUserByID(id uuid.UUID) (*entity.User, error) {
	user := new(entity.User)
	if err := r.db.Where("user_id = ?", id).Take(&user).Error; err != nil {
		return user, err
	}
	return user, nil
}

func (r *userRepository) FindUserByEmail(email string) (*entity.User, error) {
	user := new(entity.User)
	if err := r.db.Where("email = ?", email).Take(&user).Error; err != nil {
		return user, err
	}
	return user, nil
}

func (r *userRepository) FindByRole(role string, users *[]entity.User) error {
	return r.db.Where("role = ?", role).Find(users).Error
}

func (r *userRepository) CreateUser(user *entity.User) (*entity.User, error) {
	if err := r.db.Create(&user).Error; err != nil {
		return user, err
	}
	return user, nil
}

func (r *userRepository) UpdateUser(user *entity.User) (*entity.User, error) {
	// Use map to store fields to be updated.
	fields := make(map[string]interface{})

	// Update fields only if they are not empty.
	if user.Fullname != "" {
		fields["fullname"] = user.Fullname
	}
	if user.Email != "" {
		fields["email"] = user.Email
	}
	if user.Password != "" {
		fields["password"] = user.Password
	}
	if user.Role != "" {
		fields["role"] = user.Role
	}
	if user.Phone != "" {
		fields["phone"] = user.Phone
	}

	// Update the database in one query.
	if err := r.db.Model(user).Where("user_id = ?", user.User_ID).Updates(fields).Error; err != nil {
		return user, err
	}

	return user, nil
}

func (r *userRepository) DeleteUser(user *entity.User) (bool, error) {
	if err := r.db.Delete(&entity.User{}, user.User_ID).Error; err != nil {
		return false, err
	}
	return true, nil
}
func (r *userRepository) GetUserProfileByID(id uuid.UUID) (*entity.User, error) {
	key := "UserProfile:" + id.String()

	// Coba mendapatkan data dari cache Redis
	data, err := r.cacheable.Get(key)
	if err != nil && err != redis.Nil {
		return nil, err
	}

	// Jika data tidak ada di cache, ambil dari database dan simpan di cache
	if err == redis.Nil {
		user := new(entity.User)
		if err := r.db.Where("user_id = ?", id).Take(&user).Error; err != nil {
			return nil, err
		}

		// Marshal user ke format JSON
		marshalledUser, err := json.Marshal(user)
		if err != nil {
			return nil, err
		}

		// Simpan data di cache dengan masa berlaku 5 menit
		if err := r.cacheable.Set(key, marshalledUser, 5*time.Minute); err != nil {
			return nil, err
		}

		return user, nil
	}

	// Data ditemukan di cache, unmarshal data ke struct User
	var user entity.User
	if err := json.Unmarshal([]byte(data), &user); err != nil {
		return nil, err
	}

	return &user, nil
}
