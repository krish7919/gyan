# Default shell to use
SHELL := /bin/zsh

# Terminal colors
$(eval green := \033[1;32m)
$(eval yellow := \033[1;33m)
$(eval white := \033[0m)

# Absolute path to the directory containing this Makefile
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: all init

all: help

help:
	@echo -e "\n${green}TARGETS:${white}\n"
	@echo -e "  ${yellow}init${white} - Initialize the project"
	@echo -e "  ${yellow}help${white} - Display this help message"
	@echo -e "  ${yellow}lint${white} - Run linters"

init:
	pre-commit clean
	pre-commit install
	pre-commit install -t commit-msg

lint:
	@cd stinker && golangci-lint \
		--config="$(ROOT_DIR)/.golangci.yaml" \
		run
