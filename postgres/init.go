package postgres

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/todennus/shared/config"
	postgresDriver "gorm.io/driver/postgres"
	"gorm.io/gorm"
	gormlogger "gorm.io/gorm/logger"
)

func Initialize(ctx context.Context, config *config.Config) (*gorm.DB, error) {
	loglevel := config.Variable.Postgres.LogLevel
	newLogger := gormlogger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags),
		gormlogger.Config{
			SlowThreshold:             time.Second,
			LogLevel:                  gormlogger.LogLevel(loglevel),
			IgnoreRecordNotFoundError: true,
		},
	)

	var postgresDB *gorm.DB
	var err error
	for i := 0; i < config.Variable.Postgres.RetryInterval; i++ {
		postgresDB, err = gorm.Open(
			postgresDriver.Open(config.Secret.Postgres.DSN),
			&gorm.Config{Logger: newLogger, TranslateError: true},
		)
		if err == nil {
			break
		}

		config.Logger.Warn("failed-to-connect-to-postgres", "err", err)
		time.Sleep(time.Duration(config.Variable.Postgres.RetryAttempts) * time.Second)
	}

	if err != nil {
		return nil, err
	}

	config.Logger.Info("connect postgres successfully")
	return postgresDB, nil
}
