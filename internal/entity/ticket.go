package entity

import (
	"github.com/google/uuid"
)

type Ticket struct {
	Tickets_ID     uuid.UUID `json:"tickets_id"`
	Transaction_ID uuid.UUID `json:"transaction_id"`
	Event_ID       uuid.UUID `json:"event_id"`
	Code_QR        string    `json:"code_qr"`
	Name_Event     string    `json:"name_event"`
	Ticket_Date    string    `json:"ticket_date"`
	Qty            string    `json:""`
	Auditable
}

type Transactions struct {
	Transactions_id string `json:"transactions_id"`
	Cart_id         string `json:"cart_id"`
	User_id         string `json:"user_id"`
	Fullname_user   string `json:"fullname_user"`
	Trx_date        string `json:"trx_date"`
	Payment         string `json:"payment"`
	Payment_url     string `json:"payment_url"`
	Amount          string `json:"amount"`
	Status          string `json:"status"`
	Auditable
}

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

type Carts struct {
	Cart_id     string `json:"cart_id"  gorm:"primarykey"`
	User_id     string `json:"user_id"`
	Event_id    string `json:"event_id"`
	Qty         string `json:"qty"`
	Ticket_date string `json:"ticket_date"`
	Price       string `json:"price"`
	Auditable
}

func NewTicket(tickets_id, transaction_id, event_id uuid.UUID, name_event, ticket_date, qty string) *Ticket {
	return &Ticket{
		Tickets_ID:     tickets_id,
		Transaction_ID: transaction_id,
		Event_ID:       event_id,
		Name_Event:     name_event,
		Ticket_Date:    ticket_date,
		Qty:            qty,
		Auditable:      NewAuditable(),
	}
}

func NewTransaction(transactions_id, cart_id, user_id, fullname_user, trx_date, payment, payment_url, amount, status string) *Transactions {
	return &Transactions{
		Transactions_id: transactions_id,
		Cart_id:         cart_id,
		User_id:         user_id,
		Fullname_user:   fullname_user,
		Trx_date:        trx_date,
		Payment:         payment,
		Payment_url:     payment_url,
		Amount:          amount,
		Status:          status,
		Auditable:       NewAuditable(),
	}
}

type Transaction_details struct {
	Transaction_details_id string `json:"transaction_details_id"`
	Transaction_id         string `json:"transaction_id"`
	Event_id               string `json:"event_id" `
	Name_event             string `json:"name_event"`
	Qty_event              string `json:"qty_event"`
	Price                  string `json:"price"`
	Ticket_date            string `json:"ticket_date"`
	Auditable
}

func NewTransactiondetail(transaction_details_id, event_id, transaction_id, name_event, qty_event, price, ticket_date string) *Transaction_details {
	return &Transaction_details{
		Transaction_details_id: transaction_details_id,
		Transaction_id:         transaction_id,
		Event_id:               event_id,
		Name_event:             name_event,
		Qty_event:              qty_event,
		Price:                  price,
		Ticket_date:            ticket_date,
		Auditable:              NewAuditable(),
	}
}
