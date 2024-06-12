package email

import (
	"fmt"
	"net/smtp"
)

type EmailService struct {
	Auth smtp.Auth
	Host string
	Port string
	From string
}

func NewEmailService(host, port, username, password, from string) *EmailService {
	auth := smtp.PlainAuth("", username, password, host)
	return &EmailService{Auth: auth, Host: host, Port: port, From: from}
}

func (e *EmailService) Send(to, subject, body string) error {
	msg := "From: " + e.From + "\n" +
		"To: " + to + "\n" +
		"Subject: " + subject + "\n\n" +
		body
	addr := fmt.Sprintf("%s:%s", e.Host, e.Port)
	return smtp.SendMail(addr, e.Auth, e.From, []string{to}, []byte(msg))
}
