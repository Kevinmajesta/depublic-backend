package handler

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strconv"
	"time"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"
	"github.com/Kevinmajesta/depublic-backend/internal/http/binder"
	"github.com/Kevinmajesta/depublic-backend/internal/service"
	"github.com/Kevinmajesta/depublic-backend/pkg/response"
	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type EventHandler struct {
	eventService service.EventService
}

func NewEventHandler(eventService service.EventService) EventHandler {
	return EventHandler{eventService: eventService}
}

// TODO ADD EVENT
// func (h *EventHandler) AddEvent(c echo.Context) error {
// 	input := binder.EventAddRequest{}

// 	if err := c.Bind(&input); err != nil {
// 		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Wrong Input!"))
// 	}

// 	newEvent := entity.NewEvent(
// 		input.CategoryID,
// 		input.TitleEvent,
// 		input.DateEvent,
// 		input.PriceEvent,
// 		input.CityEvent,
// 		input.AddressEvent,
// 		input.QtyEvent,
// 		input.DescriptionEvent,
// 		input.ImageURL,
// 	)
// 	event, err := h.eventService.AddEvent(newEvent)
// 	if err != nil {
// 		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, err.Error()))
// 	}

// 	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Add Event Success!", event))
// }

// TRY/ERROR (Success)
// ADD FILE IMAGE
func (h *EventHandler) AddEvent(c echo.Context) error {
	req := new(binder.EventAddRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Failed to bind request"))
	}

	// Validate check nil request error
	// if err := c.Validate(req); err != nil {
	// 	return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Validation failed"))
	// }

	// Try/Error (Error) For check nil input
	// if req.CategoryID == uuid.Nil || req.TitleEvent == "" || req.DateEvent == "" ||
	// 	req.PriceEvent == 0 || req.CityEvent == "" || req.AddressEvent == "" ||
	// 	req.QtyEvent == 0 || req.DescriptionEvent == "" || req.Image == nil {
	// 	return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Can not be empty"))
	// }

	file, err := c.FormFile("image")
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Failed to retrieve image"))
	}
	src, err := file.Open()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to open image"))
	}
	defer src.Close()

	imageID := uuid.New()
	imageFilename := fmt.Sprintf("%s%s", imageID, filepath.Ext(file.Filename))
	imagePath := filepath.Join("assets", "images", imageFilename)

	dst, err := os.Create(imagePath)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to create image file"))
	}
	defer dst.Close()

	if _, err := io.Copy(dst, src); err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to copy image file"))
	}

	event := &entity.Events{
		Event_id:          uuid.New(),
		Category_id:       req.CategoryID,
		Title_event:       req.TitleEvent,
		Date_event:        req.DateEvent,
		Price_event:       req.PriceEvent,
		City_event:        req.CityEvent,
		Address_event:     req.AddressEvent,
		Qty_event:         req.QtyEvent,
		Description_event: req.DescriptionEvent,
		Image_url:         "/assets/images/" + imageFilename,
		Auditable:         entity.NewAuditable(),
	}

	createdEvent, err := h.eventService.AddEvent(event)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to create event"))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Event created successfully", createdEvent))
}

// TODO GET ALL EVENT
func (h *EventHandler) GetAllEvent(c echo.Context) error {
	events, err := h.eventService.GetAllEvent()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Get All Events Success!", events))
}

// TODO UPDATE EVENT
// UpdateEventByID handles the update of an event by ID.
func (h *EventHandler) UpdateEvent(c echo.Context) error {
	id := c.Param("id")
	eventID, err := uuid.Parse(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid ID"))
	}

	req := new(binder.EventUpdateRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Failed to bind request"))
	}

	file, err := c.FormFile("image")
	var imageURL string
	if err == nil {
		src, err := file.Open()
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to open image"))
		}
		defer src.Close()

		imageID := uuid.New()
		imageFilename := fmt.Sprintf("%s%s", imageID, filepath.Ext(file.Filename))
		imagePath := filepath.Join("assets", "images", imageFilename)

		dst, err := os.Create(imagePath)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to create image file"))
		}
		defer dst.Close()

		if _, err := io.Copy(dst, src); err != nil {
			return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to copy image file"))
		}

		imageURL = "/assets/images/" + imageFilename
	} else {
		imageURL = ""
	}

	event, err := h.eventService.GetEventByID(eventID)
	if err != nil {
		return c.JSON(http.StatusNotFound, response.ErrorResponse(http.StatusNotFound, "Event not found"))
	}

	event = entity.UpdateEvent(
		event,
		req.CategoryID,
		req.TitleEvent,
		time.Now(),
		req.PriceEvent,
		req.CityEvent,
		req.AddressEvent,
		req.QtyEvent,
		req.DescriptionEvent,
		imageURL,
	)

	updatedEvent, err := h.eventService.UpdateEvent(event)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, "Failed to update event"))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Event updated successfully", updatedEvent))
}

// TODO DELETE EVENT BY ID
func (h *EventHandler) DeleteEventByID(c echo.Context) error {
	id := c.Param("id")
	eventID, err := uuid.Parse(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid ID"))
	}

	event, err := h.eventService.DeleteEventByID(eventID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Delete Event Success!", event.DeletedAt))
}

// TODO GET EVENT BY ID
func (h *EventHandler) GetEventByID(c echo.Context) error {
	eventID, err := uuid.Parse(c.Param("event_id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid ID"))
	}

	event, err := h.eventService.GetEventByID(eventID)
	if err != nil {
		return c.JSON(http.StatusNotFound, response.ErrorResponse(http.StatusNotFound, "Event not found"))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Get Event Success!", event))
}

// TODO GET SEARCH BY TITLE

func (h *EventHandler) SearchEvents(c echo.Context) error {
	title := c.QueryParam("title_event")
	events, err := h.eventService.SearchEventsByTitle(title)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}
	if title == "" {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Name required"))
	}
	// Check if title is not available
	// if title != "title_event" {
	// 	return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Event not found"))
	// }
	return c.JSON(http.StatusOK, events)
}

// TODO FILTER
func (h *EventHandler) FilterEvents(c echo.Context) error {
	var categoryID uuid.UUID
	var startDate string
	var endDate string
	var cityEvent string
	var priceMin int
	var priceMax int

	// Parse query params
	if cid := c.QueryParam("category_id"); cid != "" {
		id, err := uuid.Parse(cid)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid category ID"))
		}
		categoryID = id
	}
	if sd := c.QueryParam("start_date"); sd != "" {
		startDate = sd
	} else {
		startDate = "2000-01-01"
	}
	if ed := c.QueryParam("end_date"); ed != "" {
		endDate = ed
	} else {
		endDate = "9999-12-31"
	}
	if ce := c.QueryParam("city_event"); ce != "" {
		cityEvent = ce
	}
	if pm := c.QueryParam("price_min"); pm != "" {
		price, err := strconv.Atoi(pm)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid minimum price"))
		}
		priceMin = price
	} else {
		priceMin = 0
	}
	if px := c.QueryParam("price_max"); px != "" {
		price, err := strconv.Atoi(px)
		if err != nil {
			return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Invalid maximum price"))
		}
		priceMax = price
	} else {
		priceMax = 999999999
	}

	events, err := h.eventService.FilterEvents(categoryID, startDate, endDate, cityEvent, priceMin, priceMax)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	if (priceMin != 0 || priceMax != 999999999 || startDate != "2000-01-01" || endDate != "9999-12-31") && len(events) == 0 {
		return c.JSON(http.StatusNotFound, response.ErrorResponse(http.StatusNotFound, "Event Not Available"))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Filter Events Success!", events))
}

// TODO SORT EVENT

func (h *EventHandler) SortEvents(c echo.Context) error {
	sortBy := c.QueryParam("sort_by")
	if sortBy == "" {
		return c.JSON(http.StatusBadRequest, response.ErrorResponse(http.StatusBadRequest, "Sort criteria required"))
	}

	events, err := h.eventService.SortEvents(sortBy)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, response.ErrorResponse(http.StatusInternalServerError, err.Error()))
	}

	return c.JSON(http.StatusOK, response.SuccessResponse(http.StatusOK, "Sort Events Success!", events))
}