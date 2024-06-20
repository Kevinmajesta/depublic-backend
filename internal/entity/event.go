package entity

type Events struct {
	Event_id          string `json:"event_id"  gorm:"primarykey"`
	Category_id       string `json:"category_id"`
	Title_event       string `json:"title_event"`
	Date_event        string `json:"date_event"`
	Price_event       string `json:"price_event"`
	City_event        string `json:"city_event"`
	Address_event     string `json:"address_event"`
	Qty_event         string `json:"qty_event"`
	Description_event string `json:"description_event"`
	Image_url         string `json:"image_url"`
	Auditable
}
