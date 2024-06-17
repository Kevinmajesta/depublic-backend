package binder

type CategoryCreateRequest struct {
	NameCategories string `json:"name_categories" validate:"required"`
}

type CategoryUpdateRequest struct {
	NameCategories string `json:"name_categories" validate:"required"`
}
