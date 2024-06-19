package repository

import (
	"errors"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type CategoryRepository interface {
	// TODO ADD
	AddCategory(category *entity.EventCategory) (*entity.EventCategory, error)
	GetAllCategory() ([]entity.EventCategory, error)
	GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error)
	GetCategoryByName(categoryName string) (*entity.EventCategory, error)

	// TODO UPDATE
	UpdateCategoryByID(category *entity.EventCategory) (*entity.EventCategory, error)
	// TODO DELETE
	DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error)
	// TODO CHECK
	CheckCategoryByName(name string) (*entity.EventCategory, error)
	CheckCategoryById(categoryID string) (*entity.EventCategory, error)
}

type categoryRepository struct {
	db *gorm.DB
}

func NewCategoryRepository(db *gorm.DB) CategoryRepository {
	return &categoryRepository{db: db}
}

// TODO ADD CATEGORY REPOSITORY
// Repo Add Category
func (r *categoryRepository) AddCategory(category *entity.EventCategory) (*entity.EventCategory, error) {
	if err := r.db.Create(&category).Error; err != nil {
		return category, err
	}
	return category, nil
}

// TODO FIND ALL CATEGORY REPOSITORY
func (r *categoryRepository) GetAllCategory() ([]entity.EventCategory, error) {
	var category []entity.EventCategory
	if err := r.db.Find(&category).Error; err != nil {
		return nil, err
	}
	return category, nil
}

// TODO FIND CATEGORY BY ID
func (r *categoryRepository) GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error) {
	var category entity.EventCategory
	if err := r.db.Find(&category, "event_categories_id = ?", categoryID).Error; err != nil {
		return nil, err
	}
	return &category, nil
}

// TODO GET CATEGORY BY NAME
// func (r *categoryRepository) GetCategoryByName(categoryName string) (*entity.EventCategory, error) {
// 	var category entity.EventCategory
// 	if err := r.db.Find(&category, "name_categories = ?", categoryName).Error; err != nil {
// 		return nil, err
// 	}
// 	return &category, nil
// }

func (r *categoryRepository) GetCategoryByName(categoryName string) (*entity.EventCategory, error) {
	var category entity.EventCategory
	if err := r.db.Where("name_categories = ?", categoryName).First(&category).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil // Return nil if no category found
		}
		return nil, err
	}
	return &category, nil
}

// TODO UPDATE CATEGORY BY ID
func (r *categoryRepository) UpdateCategoryByID(category *entity.EventCategory) (*entity.EventCategory, error) {
	// Find the existing event by ID
	var existingCategory entity.EventCategory
	if err := r.db.Find(&existingCategory, "event_categories_id = ?", category.EventCategoriesID).Error; err != nil {
		return nil, err
	}

	// Update the fields
	existingCategory.NameCategories = category.NameCategories

	// Save the changes
	if err := r.db.Save(&existingCategory).Error; err != nil {
		return nil, err
	}

	return &existingCategory, nil
}

// TODO DELETE CATEGORY BY ID
func (r *categoryRepository) DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error) {
	var category entity.EventCategory
	// Unscoped delete (Hard Delete)
	if err := r.db.Where("event_categories_id = ?", categoryID).Unscoped().Delete(&category).Error; err != nil {
		return nil, err
	}

	return &category, nil
}

// TODO Check Name Category
func (r *categoryRepository) CheckCategoryByName(categoryName string) (*entity.EventCategory, error) {
	var category entity.EventCategory
	if err := r.db.Where("name_categories = ?", categoryName).Find(&category).Error; err != nil {
		// if errors.Is(err, gorm.ErrRecordNotFound) {
		// 	return nil, nil
		// }
		return nil, err
	}
	return &category, nil
}

func (r *categoryRepository) CheckCategoryById(categoryID string) (*entity.EventCategory, error) {
	var category entity.EventCategory
	if err := r.db.Where("id_event_categories = ?", categoryID).Find(&category).Error; err != nil {
		// if errors.Is(err, gorm.ErrRecordNotFound) {
		// 	return nil, nil
		// }
		return nil, err
	}
	return &category, nil
}
