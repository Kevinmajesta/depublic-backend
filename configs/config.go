package configs

import (
	"errors"

	"github.com/caarlos0/env/v10"
	"github.com/joho/godotenv"
)

type Config struct {
	Env            string         `env:"ENV" envDefault:"dev"`
	Port           string         `env:"PORT" envDefault:"8080"`
	Postgres       PostgresConfig `envPrefix:"POSTGRES_"`
	Redis          RedisConfig    `envPrefix:"REDIS_"`
	JWT            JwtConfig      `envPrefix:"JWT_"`
	MidtransConfig MidtransConfig `envPrefix:"MIDTRANS_"`
	SMTP           SMTPConfig     `envPrefix:"SMTP_"`
}

type MidtransConfig struct {
	ServerKey string `env:"SERVER_KEY"`
}

type PostgresConfig struct {
	Host     string `env:"HOST" envDefault:"localhost"`
	Port     string `env:"PORT" envDefault:"5432"`
	User     string `env:"USER" envDefault:"depublic"`
	Password string `env:"PASSWORD" envDefault:"depublic"`
	Database string `env:"DATABASE" envDefault:"postgres"`
}

type JwtConfig struct {
	SecretKey string `env:"SECRET_KEY"`
}

type RedisConfig struct {
	Host     string `env:"HOST" envDefault:"localhost"`
	Port     string `env:"PORT" envDefault:"6379"`
	Password string `env:"PASSWORD" envDefault:""`
}

type SMTPConfig struct {
	Host     string `env:"HOST" envDefault:"smtp.larksuite.com"`
	Port     string `env:"PORT" envDefault:"587"`
	Password string `env:"Password" envDefault:"psE2030oYa1OUhA4"`
}

func NewConfig(envPath string) (*Config, error) {
	err := godotenv.Load(envPath)
	if err != nil {
		return nil, errors.New("failed to load .env file")
	}

	cfg := new(Config)

	err = env.Parse(cfg)
	if err != nil {
		return nil, errors.New("failed to parse config file")
	}

	return cfg, nil
}
