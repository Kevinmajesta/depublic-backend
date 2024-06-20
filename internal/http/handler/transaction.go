package handler

import (
	"bytes"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/http/binder"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/response"
	"github.com/go-playground/validator/v10"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type TransactionHandler struct {
	transactionService service.TransactionService
}

type CustomValidator struct {
	Validator *validator.Validate
}

type Responsemeta struct {
	Message string
	Status  bool
}

type TrasactionCreateRequestdata struct {
	Cart_id       string `json:"cart_id" validate:"required,cart_id"`
	User_id       string `json:"user_id" validate:"required,user_id"`
	Fullname_user string `json:"fullname_user" validate:"required,fullname_user"`
	Trx_date      string `json:"trx_date" validate:"required,trx_date"`
	Payment       string `json:"payment" validate:"required,payment"`
	Payment_url   string `json:"payment_url" validate:"required,payment_url"`
	Amount        string `json:"amount" validate:"required,amount"`
	Status        string `json:"status" validate:"required,status"`
}

func (cv *CustomValidator) Validate(i interface{}) error {
	return cv.Validator.Struct(i)
	// Optionally, you could return the error to give each route more control over the status code
}

type Person struct {
	Cart_id string `json:"cart_id"`
	User_id int    `json:"user_id"`
	// City string `json:"city"`
}

func NewTransactionHandler(transactionService service.TransactionService) TransactionHandler {
	return TransactionHandler{transactionService: transactionService}
}

func calculatePPN(amount float64, tarifPPN float64) float64 {
	return amount * (tarifPPN / 100.0)
}

func (h *TransactionHandler) CreateTransaction(c echo.Context) error {
	input := binder.TrasactionCreateRequest{}

	if err := c.Bind(&input); err != nil {
		return c.
			JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Input yang dimasukkan salah"))
	}

	Cart_id := uuid.MustParse(input.Cart_id)

	cartdata, err := h.transactionService.FindCartByID(Cart_id)

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}
	if cartdata.Cart_id == "" {
		return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "Sorry! We found no Cart data"))
	}

	Event_id := uuid.MustParse(cartdata.Event_id)

	eventdata, err := h.transactionService.FindEventByID(Event_id)

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	if eventdata.Event_id == "" {
		return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "Sorry! We found Event no data"))
	}

	User_id := uuid.MustParse(input.User_id)

	userdata, err := h.transactionService.FindUserByID(User_id)

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	if userdata.User_id == "" {
		return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "Sorry! We found User no data"))
	}

	if userdata.Role == "user" {

		qtytrx := cartdata.Qty
		pricetrx := eventdata.Price_event

		amount1, err := strconv.Atoi(pricetrx)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! We failed to convert"))
		}

		amount2, err := strconv.Atoi(qtytrx)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! We failed to convert"))
		}

		amount := float64(amount1 * amount2)
		ppn := calculatePPN(amount, 11)
		amounttotal := int((amount + ppn))

		amountfinal := strconv.Itoa(amounttotal)

		trx_id := uuid.New().String()
		status := "0"

		url := "https://app.sandbox.midtrans.com/snap/v1/transactions"
		// "enabled_payments": ["bca_va"],
		data := map[string]interface{}{
			"transaction_details": map[string]interface{}{
				"order_id":     trx_id,
				"gross_amount": int64(amounttotal),
			},

			"enabled_payments": []string{input.Payment},
			"customer_details": map[string]interface{}{
				"first_name": userdata.Fullname,
				"last_name":  "",
				"email":      userdata.Email,
				"phone":      "0" + userdata.Phone,
				"billing_address": map[string]interface{}{
					"first_name":   userdata.Fullname,
					"last_name":    "",
					"email":        userdata.Email,
					"phone":        strconv.Itoa(0) + userdata.Phone,
					"address":      "Indanesia",
					"city":         "Jakarta",
					"postal_code":  "12190",
					"country_code": "IDN",
				},
			},
		}

		// Mengubah data menjadi format JSON
		payload, err := json.Marshal(data)
		if err != nil {
			log.Fatalf("Failed to marshal JSON: %v", err)
		}

		// Membuat request HTTP POST
		req, err := http.NewRequest("POST", url, bytes.NewBuffer(payload))
		if err != nil {
			log.Fatalf("Failed to create HTTP request: %v", err)
		}

		// Menambahkan header Content-Type: application/json
		req.Header.Set("Content-Type", "application/json")
		req.Header.Set("Authorization", "Basic U0ItTWlkLXNlcnZlci1kazQ1S0Zpb21QRW9UajFqeWpiWWd1Z1k6Og==")

		// Membuat klien HTTP
		client := &http.Client{}

		// Mengirim request ke server
		resp, err := client.Do(req)
		if err != nil {
			log.Fatalf("Failed to send HTTP request: %v", err)
		}
		defer resp.Body.Close()

		// Membaca respons dari server
		var snapRequest map[string]interface{}
		err = json.NewDecoder(resp.Body).Decode(&snapRequest)
		snapRequesturl := snapRequest["redirect_url"]
		paymenturl := snapRequesturl.(string)
		if err != nil {
			log.Fatalf("Failed to decode JSON response: %v", err)
		}

		NewTrx := entity.NewTransaction(trx_id, input.Cart_id, input.User_id, userdata.Fullname, input.Payment, paymenturl, amountfinal, status)

		if NewTrx.Status == "1" {
			return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "The Payment Status value cannot be (True or 1). required value (False or 0)"))
		}

		if NewTrx.Status == "true" {
			return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "The Payment Status value cannot be (True or 1). required value (False or 0)"))
		} else if NewTrx.Status == "True" {
			return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "The Payment Status value cannot be (True or 1). required value (False or 0)"))
		}

		if NewTrx.Cart_id == "" {
			return c.JSON(http.StatusUnprocessableEntity, response.Errorfieldempty(http.StatusUnprocessableEntity, "Card_id"))
		}
		if NewTrx.User_id == "" {
			return c.JSON(http.StatusUnprocessableEntity, response.Errorfieldempty(http.StatusUnprocessableEntity, "User_id"))
		}
		if NewTrx.Payment == "" {
			return c.JSON(http.StatusUnprocessableEntity, response.Errorfieldempty(http.StatusUnprocessableEntity, "Payment"))
		}

		qtyevent := cartdata.Qty
		priceevent := eventdata.Price_event

		event1, err := strconv.Atoi(priceevent)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! We failed to convert"))
		}

		event2, err := strconv.Atoi(qtyevent)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! We failed to convert"))
		}

		price := event1 * event2
		pricefinal := strconv.Itoa(price)

		trx_iddetail := uuid.New().String()

		NewTrxdetail := entity.NewTransactiondetail(trx_iddetail, cartdata.Event_id, trx_id, eventdata.Title_event, cartdata.Qty, pricefinal, cartdata.Ticket_date)

		transaction, err := h.transactionService.CreateTransaction(NewTrx)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}
		transactiondetail, err := h.transactionService.CreateTransactiondetail(NewTrxdetail)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}

		Pembayaran := make(map[string]interface{})

		Pembayaran["Payment_URL"] = snapRequesturl
		Pembayaran["Payment_Bank"] = input.Payment
		Pembayaran["Gross_Amount"] = amounttotal
		Pembayaran["PPN"] = ppn
		Pembayaran["Amount"] = amount

		fields := make(map[string]interface{})

		fields["Transaction_ID"] = transaction.Transactions_id
		fields["Transaction_Detail_ID"] = transactiondetail.Transaction_details_id
		fields["Pembayaran"] = Pembayaran

		return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Create Data New Transaction", fields))

	} else if userdata.Role == "admin" {
		return c.JSON(http.StatusForbidden, response.ErrorResponse(http.StatusForbidden, "Sorry! access denied"))
	} else {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! we cannot recognize your account"))
	}
}

func (h *TransactionHandler) CheckPayTransaction(c echo.Context) error {
	var input binder.CheckTrxFindByIDRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	transactions_id := uuid.MustParse(input.Transactions_id)

	transaction, err := h.transactionService.FindTrxByID(transactions_id)

	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	}

	// transactions_id_checkpay := uuid.MustParse(input.Transactions_id)
	transactions_id_checkpay := transactions_id.String()

	url := "https://api.sandbox.midtrans.com/v2/" + transactions_id_checkpay + "/status"
	// "enabled_payments": ["bca_va"],
	data := map[string]interface{}{}

	// Mengubah data menjadi format JSON
	payload, err := json.Marshal(data)
	if err != nil {
		log.Fatalf("Failed to marshal JSON: %v", err)
	}

	// Membuat request HTTP POST
	req, err := http.NewRequest("GET", url, bytes.NewBuffer(payload))
	if err != nil {
		log.Fatalf("Failed to create HTTP request: %v", err)
	}

	// Menambahkan header Content-Type: application/json
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Basic U0ItTWlkLXNlcnZlci1kazQ1S0Zpb21QRW9UajFqeWpiWWd1Z1k6Og==")

	// Membuat klien HTTP
	client := &http.Client{}

	// Mengirim request ke server
	resp, err := client.Do(req)
	if err != nil {
		log.Fatalf("Failed to send HTTP request: %v", err)
	}
	defer resp.Body.Close()

	// Membaca respons dari server
	var checkpayreq map[string]interface{}
	err = json.NewDecoder(resp.Body).Decode(&checkpayreq)
	sttscode := checkpayreq["status_code"]
	trxped := checkpayreq["transaction_status"]

	if err != nil {
		log.Fatalf("Failed to decode JSON response: %v", err)
	}

	if sttscode == "404" {
		payreload := make(map[string]interface{})

		payreload["Payment_URL"] = transaction.Payment_url
		payreload["Payment_Bank"] = transaction.Payment
		payreload["Message"] = "Payment In Process"

		return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Check Pay", payreload))
	} else if trxped == "pending" {
		payreload := make(map[string]interface{})

		payreload["Payment_URL"] = transaction.Payment_url
		payreload["Payment_Bank"] = transaction.Payment
		payreload["Message"] = "Payment Pending"

		return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Check Pay", payreload))
	} else if trxped == "expire" {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! payment expired"))
	} else if trxped == "cancel" {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! payment cancel"))
	} else if trxped == "settlement" {

		statustrx := "true"

		updatetrx := entity.UpdateTransaction(input.Transactions_id, statustrx)

		updatedTrx, err := h.transactionService.UpdateTransaction(updatetrx)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}

		transaction_id_detail := uuid.MustParse(input.Transactions_id)
		transactiondetail, err := h.transactionService.FindTrxdetailByID(transaction_id_detail)

		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}

		if transactiondetail.Event_id == "" {
			return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "Sorry! We found Event no data"))
		}
		Event_id := uuid.MustParse(transactiondetail.Event_id)
		eventdata, err := h.transactionService.FindEventByID(Event_id)

		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}

		if eventdata.Event_id == "" {
			return c.JSON(http.StatusFound, response.ErrorResponse(http.StatusFound, "Sorry! We found Event no data"))
		}

		ticket_id := uuid.New().String()
		codeqr := uuid.New().String()
		NewTicketdata := entity.NewTicket(ticket_id, transaction.Transactions_id, eventdata.Event_id, codeqr, eventdata.Title_event, transactiondetail.Qty_event)

		ticketdata, err := h.transactionService.CreateTicket(NewTicketdata)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}
		fields := make(map[string]interface{})

		fields["Ticket_id"] = ticketdata.Tickets_id
		fields["Status_Payment"] = checkpayreq["transaction_status"]
		fields["Status_Transaksi"] = updatedTrx.Status
		fields["Message"] = "Payment Success"

		return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Check Pay", fields))
	} else {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! System error"))
	}

}

func (h *TransactionHandler) FindAllTransaction(c echo.Context) error {
	var input binder.GetAllRequest

	if err := c.Bind(&input); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "ada kesalahan input"))
	}

	// if input.Transactions_id == "" {
	// 	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Get All Transaction", nil))
	// } else if input.User_id == "" {
	// 	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success Get All Transaction", nil))
	// }

	if input.Key == "trx" {
		trx_id := uuid.MustParse(input.Transactions_id)

		trxdata, err := h.transactionService.FindTrxByID(trx_id)

		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}
		if trxdata.Transactions_id == "" {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Data Not Found"))
		} else {
			return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success menampilkan data Transaction", trxdata))
		}
	}
	if input.Key == "trx_user" {
		trx_id := uuid.MustParse(input.Transactions_id)
		User_id := uuid.MustParse(input.User_id)

		trxdatauser, err := h.transactionService.FindTrxrelationByID(trx_id, User_id)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}
		if trxdatauser.Transactions_id == "" && trxdatauser.User_id == "" {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Data Not Found"))
		} else {
			return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success menampilkan data Transaction", trxdatauser))
		}
	}

	if input.Key == "trx_admin_all" {
		User_id := uuid.MustParse(input.User_id)
		valuser, err := h.transactionService.FindUserByID(User_id)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
		}

		if valuser.Role == "admin" {
			trxdatauser, err := h.transactionService.FindTrxrelationadminByID(User_id)
			if err != nil {
				return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
			}
			if trxdatauser == nil {
				return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Data Not Found"))
			} else {
				return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Success menampilkan data Transaction", trxdatauser))
			}
		}
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sorry! access denied"))
	}
	return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Format Key Not Found"))

	// transaction, err := h.transactionService.FindAllTransaction()
	// if err != nil {
	// 	return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
	// }

}
