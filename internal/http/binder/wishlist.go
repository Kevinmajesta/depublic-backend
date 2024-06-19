package binder

type WishlistRequest struct {
	UserId  string `json:"user_id"`
	EventId string `json:"event_id"`
}

type RemoveWishlistRequest struct {
	UserId  string `json:"user_id"`
	EventId string `json:"event_id"`
}
