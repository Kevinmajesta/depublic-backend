package service

import (
	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/google/uuid"
)

// TODO ADD ERROR BY CHECK NAME

type CategoryService interface {
	// TODO ADD CATEGORY
	AddCategory(category *entity.EventCategory) (*entity.EventCategory, error)
	GetAllCategory() ([]entity.EventCategory, error)
	GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error)
	GetCategoryByName(categoryName string) (*entity.EventCategory, error)
	// TODO CHECK
	CheckCategoryByName(name string) (*entity.EventCategory, error)
	CheckCategoryById(categoryID string) (*entity.EventCategory, error)
	// TODO UPDATE
	// UpdateCategoryByID(categoryID uuid.UUID, categoryName string) (*entity.EventCategory, error)
	UpdateCategoryByID(category *entity.EventCategory) (*entity.EventCategory, error)
	// TODO DELETE
	DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error)
}

type categoryService struct {
	categoryRepository repository.CategoryRepository
}

func NewCategoryService(categoryRepository repository.CategoryRepository) CategoryService {
	return &categoryService{categoryRepository: categoryRepository}
}

// TODO ADD CATEGORY SERVICE
// Service Add Category
func (s *categoryService) AddCategory(category *entity.EventCategory) (*entity.EventCategory, error) {
	return s.categoryRepository.AddCategory(category)
}

// TODO GET CATEGORY
func (s *categoryService) GetAllCategory() ([]entity.EventCategory, error) {
	return s.categoryRepository.GetAllCategory()
}

// GET BY ID
func (s *categoryService) GetCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error) {
	return s.categoryRepository.GetCategoryByID(categoryID)
}

// GET By Name
func (s *categoryService) GetCategoryByName(categoryName string) (*entity.EventCategory, error) {
	return s.categoryRepository.GetCategoryByName(categoryName)
}

// Check category name exist
func (s *categoryService) CheckCategoryByName(categoryName string) (*entity.EventCategory, error) {
	return s.categoryRepository.CheckCategoryByName(categoryName)
}

// Check category id exist
func (s *categoryService) CheckCategoryById(categoryID string) (*entity.EventCategory, error) {
	return s.categoryRepository.CheckCategoryById(categoryID)
}

// TODO UPDATE
// BACKUP
// func (s *categoryService) UpdateCategoryByID(categoryID uuid.UUID, categoryName string) (*entity.EventCategory, error) {
// 	category := &entity.EventCategory{
// 		EventCategoriesID: categoryID,
// 		NameCategories:    categoryName,
// 	}
// 	return s.categoryRepository.UpdateCategoryByID(category)
// }

// TRY/ERROR (SUCCESS)
func (s *categoryService) UpdateCategoryByID(categoryID *entity.EventCategory) (*entity.EventCategory, error) {
	return s.categoryRepository.UpdateCategoryByID(categoryID)
}

// TODO DELETE
func (s *categoryService) DeleteCategoryByID(categoryID uuid.UUID) (*entity.EventCategory, error) {
	return s.categoryRepository.DeleteCategoryByID(categoryID)
}
