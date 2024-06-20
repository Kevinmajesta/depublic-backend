package email

import (
	"fmt"

	"github.com/Kevinmajesta/depublic-backend/internal/entity"

	"gopkg.in/gomail.v2"
)

type EmailSender struct {
	Config *entity.Config
}

func NewEmailSender(config *entity.Config) *EmailSender {
	return &EmailSender{Config: config}
}

func (e *EmailSender) SendEmail(to []string, subject, body string) error {
	from := "info@amygdala.cloud"
	password := e.Config.SMTP.Password
	smtpHost := e.Config.SMTP.Host

	mailer := gomail.NewMessage()
	mailer.SetHeader("From", from)
	mailer.SetHeader("To", to...)
	mailer.SetHeader("Subject", subject)
	mailer.SetBody("text/plain", body)

	dialer := gomail.NewDialer(smtpHost, 587, from, password)
	err := dialer.DialAndSend(mailer)
	if err != nil {
		return fmt.Errorf("failed to send email: %v", err)
	}

	return nil
}

func (e *EmailSender) SendWelcomeEmail(to, message string) error {
	subject := "Welcome Email | Depublic"
	body := "This is a welcome email message from depublic"
	return e.SendEmail([]string{to}, subject, body)
}

func (e *EmailSender) SendResetPasswordEmail(to, resetCode string) error {
	subject := "Reset Password | Depublic"
	body := fmt.Sprintf("Please use the following code to reset your password: %s", resetCode)
	return e.SendEmail([]string{to}, subject, body)
}

// func (e *EmailSender) SendVerificationEmail(to, code string) error {
// 	subject := "Verify Your Email | Depublic"
// 	body := fmt.Sprintf("Please use the following code to verify your email: %s", code)
// 	return e.SendEmail([]string{to}, subject, body)
// }
