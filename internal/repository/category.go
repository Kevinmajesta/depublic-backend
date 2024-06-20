package repository

import (
	"errors"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type CategoryRepository interface {
	// TODO ADD
	AddCategory(category *entity.EventCategories) (*entity.EventCategories, error)
	// TODO GET
	GetAllCategory() ([]entity.EventCategories, error)
	GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategories, error)
	GetCategoryByName(categoryName string) (*entity.EventCategories, error)
	// TODO UPDATE
	UpdateCategoryByID(category *entity.EventCategories) (*entity.EventCategories, error)
	// TODO DELETE
	DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategories, error)
	// TODO CHECK
	CheckCategoryByName(name string) (*entity.EventCategories, error)
	CheckCategoryById(categoryID string) (*entity.EventCategories, error)
}

type categoryRepository struct {
	db *gorm.DB
}

func NewCategoryRepository(db *gorm.DB) CategoryRepository {
	return &categoryRepository{db: db}
}

// TODO ADD CATEGORY REPOSITORY
// Repo Add Category
func (r *categoryRepository) AddCategory(category *entity.EventCategories) (*entity.EventCategories, error) {
	query := r.db
	if err := query.Create(&category).Error; err != nil {
		return category, err
	}
	return category, nil
}

// TODO FIND ALL CATEGORY REPOSITORY
func (r *categoryRepository) GetAllCategory() ([]entity.EventCategories, error) {
	var category []entity.EventCategories
	query := r.db
	if err := query.Find(&category).Error; err != nil {
		return nil, err
	}
	return category, nil
}

// TODO FIND CATEGORY BY ID
func (r *categoryRepository) GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategories, error) {
	var category entity.EventCategories
	query := r.db
	if err := query.Find(&category, "event_category_id = ?", categoryID).Error; err != nil {
		return nil, err
	}
	return &category, nil
}

// TODO GET CATEGORY BY NAME
// func (r *categoryRepository) GetCategoryByName(categoryName string) (*entity.EventCategories, error) {
// 	var category entity.EventCategories
// query := r.db
// 	if err := query.Find(&category, "name_categories = ?", categoryName).Error; err != nil {
// 		return nil, err
// 	}
// 	return &category, nil
// }

func (r *categoryRepository) GetCategoryByName(categoryName string) (*entity.EventCategories, error) {
	var category entity.EventCategories
	query := r.db
	if err := query.Where("name_categories = ?", categoryName).First(&category).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil // Return nil if no category found
		}
		return nil, err
	}
	return &category, nil
}

// TODO UPDATE CATEGORY BY ID
func (r *categoryRepository) UpdateCategoryByID(category *entity.EventCategories) (*entity.EventCategories, error) {
	// Find the existing event by ID
	var existingCategory entity.EventCategories
	query := r.db
	if err := query.Find(&existingCategory, "event_category_id = ?", category.EventCategoryID).Error; err != nil {
		return nil, err
	}

	// Update the fields
	existingCategory.NameCategories = category.NameCategories

	// Save the changes
	if err := query.Save(&existingCategory).Error; err != nil {
		return nil, err
	}

	return &existingCategory, nil
}

// TODO DELETE CATEGORY BY ID
func (r *categoryRepository) DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategories, error) {
	var category entity.EventCategories
	query := r.db
	// Unscoped delete (Hard Delete)
	if err := query.Where("event_category_id = ?", categoryID).Unscoped().Delete(&category).Error; err != nil {
		return nil, err
	}

	return &category, nil
}

// TODO Check Name Category
func (r *categoryRepository) CheckCategoryByName(categoryName string) (*entity.EventCategories, error) {
	var category entity.EventCategories
	query := r.db
	if err := query.Where("name_categories = ?", categoryName).Find(&category).Error; err != nil {
		// if errors.Is(err, gorm.ErrRecordNotFound) {
		// 	return nil, nil
		// }
		return nil, err
	}
	return &category, nil
}

func (r *categoryRepository) CheckCategoryById(categoryID string) (*entity.EventCategories, error) {
	var category entity.EventCategories
	query := r.db
	if err := query.Where("id_event_categories = ?", categoryID).Find(&category).Error; err != nil {
		// if errors.Is(err, gorm.ErrRecordNotFound) {
		// 	return nil, nil
		// }
		return nil, err
	}
	return &category, nil
}
