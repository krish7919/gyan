package cmd

import (
	"log/slog"
	"os"
)

func initLogger() {
	handlerOptions := &slog.HandlerOptions{
		Level: slog.LevelInfo,
	}

	if isDebugLoggingEnabled {
		handlerOptions = &slog.HandlerOptions{
			Level: slog.LevelDebug,
		}
	}

	logger := slog.New(slog.NewJSONHandler(os.Stdout, handlerOptions))
	slog.SetDefault(logger)
}
