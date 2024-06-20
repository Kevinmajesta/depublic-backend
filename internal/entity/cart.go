package entity

type Carts struct {
	Cart_id     string `json:"cart_id"  gorm:"primarykey"`
	User_id     string `json:"user_id"`
	Event_id    string `json:"event_id"`
	Qty         string `json:"qty"`
	Ticket_date string `json:"ticket_date"`
	Price       string `json:"price"`
	Auditable
}
