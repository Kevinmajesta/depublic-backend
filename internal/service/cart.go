package service

import (
	"errors"
	"strconv"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/repository"
	"github.com/google/uuid"
)

type CartService interface {
	GetAllCart() ([]entity.Carts, error)
	GetCartById(CartId uuid.UUID) (*entity.Carts, error)
	GetCartByUserId(UserId uuid.UUID) (*entity.Carts, error)
	AddToCart(UserId, EventId uuid.UUID) (*entity.Carts, error)
	RemoveCart(CartId uuid.UUID) (bool, error)
	UpdateQuantityAdd(UserId, EventId uuid.UUID) error
	UpdateQuantityLess(UserId, EventId uuid.UUID) error
}

type cartService struct {
	cartRepository repository.CartRepository
	repo           repository.EventRepository
}

func NewCartService(cartRepository repository.CartRepository, repo repository.EventRepository) CartService {
	return &cartService{cartRepository: cartRepository, repo: repo}
}

func (s *cartService) GetAllCart() ([]entity.Carts, error) {
	carts, err := s.cartRepository.GetAllCart()
	if err != nil {
		return nil, err
	}
	return carts, nil
}

func (s *cartService) GetCartById(CartId uuid.UUID) (*entity.Carts, error) {
	return s.cartRepository.FindCartById(CartId)
}

func (s *cartService) GetCartByUserId(UserId uuid.UUID) (*entity.Carts, error) {

	eventAdd, err := s.cartRepository.CheckEventAdd(UserId)
	if err != nil {
		return nil, err
	}

	//check if user doesn't have an event in carts
	if eventAdd == false {
		return nil, errors.New("this user doesn't have any events in cart")
	}

	return s.cartRepository.GetCartByUserId(UserId)
}

func (s *cartService) AddToCart(UserId, EventId uuid.UUID) (*entity.Carts, error) {

	//check if the user already has a quantity of an event in his cart.
	exist, err := s.cartRepository.CheckIfEventAlreadyAdded(UserId, EventId)
	if err != nil {
		return nil, err
	}

	//if it exist cannot add again event
	if exist {
		return nil, errors.New("you've already added this event!")
	}

	//check max add 1 event by user
	eventAdd, err := s.cartRepository.CheckEventAdd(UserId)
	if err != nil {
		return nil, err
	}

	if eventAdd {
		return nil, errors.New("max add of cart one event!")
	}

	// Check available quantity for the event
	qtyEvent, err := s.repo.CheckQtyEvent(EventId)
	if err != nil {
		return nil, err
	}

	// If event is out of stock
	if qtyEvent < 1 {
		return nil, errors.New("out of stock")
	}

	// Get the price of the event
	priceEvent, err := s.repo.CheckPriceEvent(EventId)
	if err != nil {
		return nil, err
	}

	// Get the date of the event
	dateEvent, err := s.repo.CheckDateEvent(EventId)
	if err != nil {
		return nil, err
	}

	// Calculate the total price
	pricetot := priceEvent * 1
	totalPrice := strconv.Itoa(pricetot)

	// Create the new cart entry
	cart := &entity.Carts{
		Cart_id:     uuid.New().String(),
		User_id:     UserId.String(),
		Event_id:    EventId.String(),
		Qty:         "1",
		Ticket_date: dateEvent,
		Price:       totalPrice,
		Auditable:   entity.NewAuditable(),
	}

	// Add the new cart entry to the repository
	err = s.cartRepository.CreateCart(cart)
	if err != nil {
		return nil, err
	}

	// Decrease the stock in the events table
	err = s.repo.DecreaseEventStock(EventId, 1)
	if err != nil {
		return nil, err
	}

	return cart, nil
}

func (s *cartService) UpdateQuantityAdd(UserId, EventId uuid.UUID) error {
	// Mendapatkan kuantitas terakhir di keranjang
	lastQtyCart, err := s.cartRepository.GetUserTotalQtyInCart(UserId, EventId)
	if err != nil {
		return err
	}

	// Jika kuantitas di keranjang sudah 1 atau kurang, kembalikan error
	if lastQtyCart >= 5 {
		return errors.New("you cannot update quantity more than 5")
	}

	// Mengurangi kuantitas di keranjang
	err = s.cartRepository.UpdateQuantityAdd(UserId, EventId)
	if err != nil {
		return err
	}

	// Mengambil harga dari event yang terkait
	price, err := s.repo.CheckPriceEvent(EventId)
	if err != nil {
		return err
	}

	// Menghitung harga total baru setelah mengurangi kuantitas
	newTotalPrice := price * int(lastQtyCart+1)

	// Update total harga di keranjang
	err = s.cartRepository.UpdateTotalPrice(UserId, EventId, newTotalPrice)
	if err != nil {
		return err
	}

	// Menambahkan kembali stok yang telah dikurangi
	err = s.repo.DecreaseEventStock(EventId, 1)
	if err != nil {
		return err
	}

	return nil
}

func (s *cartService) UpdateQuantityLess(UserId, EventId uuid.UUID) error {
	// retrieve the last quantity of users and event
	lastQtyCart, err := s.cartRepository.GetUserTotalQtyInCart(UserId, EventId)
	if err != nil {
		return err
	}

	// check if the last quantity is less than 1
	if lastQtyCart <= 1 {
		return errors.New("you cannot update quantity less than 1")
	}

	// subtract quantity from the cart
	err = s.cartRepository.UpdateQuantityLess(UserId, EventId)
	if err != nil {
		return err
	}

	// retrieve a price from containing the event
	price, err := s.repo.CheckPriceEvent(EventId)
	if err != nil {
		return err
	}

	// calculate the new amount after subtracting quantities
	newTotalPrice := price * int(lastQtyCart-1)

	// update amount of carts
	err = s.cartRepository.UpdateTotalPrice(UserId, EventId, newTotalPrice)
	if err != nil {
		return err
	}

	// adding back stock that has been reduced
	err = s.repo.IncreaseEventStock(EventId, 1)
	if err != nil {
		return err
	}

	return nil
}

func (s *cartService) RemoveCart(CartId uuid.UUID) (bool, error) {
	// Ambil informasi tentang cart berdasarkan cart_id
	cart, err := s.cartRepository.FindCartById(CartId)
	if err != nil {
		return false, err
	}

	// Hapus entri dari keranjang
	return s.cartRepository.RemoveCart(cart)
}
