# Default shell to use
SHELL := /bin/bash

# Absolute path to the directory containing this Makefile
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Absolute path to the bin directory where compiled binaries will be stored
BIN_DIR       := $(ROOT_DIR)/bin

$(eval GREEN := \033[1;32m)
$(eval YELLOW := \033[1;33m)
$(eval WHITE := \033[0m)

define colored-echo
    @echo -e "${YELLOW}$(1)${WHITE}"
endef

# This should _always_ be the first/default target, so that running `make`
# without arguments shows the help message.
.PHONY: all
all: help

########### Hidden targets for certificate generation ###########

.PHONY: --clean-certs
--clean-certs:
	@$(call colored-echo,"Deleting existing certificates...")
	@rm -f "$(ROOT_DIR)/shared/generated/certs/*"
	@$(call colored-echo,"done!\\n")

.PHONY: --gen-ca-cert
--gen-ca-cert:
	@$(call colored-echo,"Generating CA certificate and key...")
	@cd "$(ROOT_DIR)/shared/generated/certs" \
		&& openssl req \
			-noenc \
			-x509 \
			-days 14 \
			-newkey ed25519 \
			-keyout ca.key \
			-out ca.crt \
			-subj "/CN=RCE CA/O=RCE ORG/C=UK"
# 		&& openssl x509 -text -noout -in ca.crt
	@$(call colored-echo,"done!\\n")

.PHONY: --gen-server-cert
--gen-server-cert:
	@$(call colored-echo,"Generating server certificate and key...")
	@cd "$(ROOT_DIR)/shared/generated/certs" \
		&& openssl req \
			-noenc \
			-newkey ed25519 \
			-subj "/CN=RCE Server/O=RCE ORG/C=UK" \
			-keyout server.key \
			-out server.csr \
		&& echo "Signing server certificate with CA..." \
		&& openssl x509 \
			-req \
			-in server.csr \
			-CA ca.crt \
			-CAkey ca.key \
			-CAserial ca.srl \
			-CAcreateserial \
			-days 14 \
			-sha256 \
			-extensions v3_req \
			-extfile <(printf "[v3_req]\nsubjectAltName=DNS:localhost") \
			-out server.crt
# 		&& openssl x509 -text -noout -in server.crt
	@$(call colored-echo,"done!\\n")

.PHONY: --gen-client-certs
--gen-client-certs:
	@$(call colored-echo,"Generating allowed client certificate and key...")
	@cd "$(ROOT_DIR)/shared/generated/certs" \
		&& openssl req \
			-noenc \
			-newkey ed25519 \
			-subj "/CN=client 1/O=RCE Allowed Client/C=UK" \
			-keyout client-allowed.key \
			-out client-allowed.csr \
		&& echo "Signing client certificate with CA..." \
		&& openssl x509 \
			-req \
			-in client-allowed.csr \
			-CA ca.crt \
			-CAkey ca.key \
			-CAserial ca.srl \
			-days 14 \
			-sha256 \
			-out client-allowed.crt
#		&& openssl x509 -text -noout -in client-allowed.crt
	@$(call colored-echo,"done!\\n")
	@$(call colored-echo,"Generating restricted client certificate and key...")
	@cd "$(ROOT_DIR)/shared/generated/certs" \
		&& openssl req \
			-noenc \
			-newkey ed25519 \
			-subj "/CN=client 2/O=RCE Restricted Client/C=UK" \
			-keyout client-restricted.key \
			-out client-restricted.csr \
		&& echo "Signing client certificate with CA..." \
		&& openssl x509 \
			-req \
			-in client-restricted.csr \
			-CA ca.crt \
			-CAkey ca.key \
			-CAserial ca.srl \
			-days 14 \
			-sha256 \
			-out client-restricted.crt
# 		&& openssl x509 -text -noout -in client-restricted.crt
	@$(call colored-echo,"done!\\n")

.PHONY: clean
clean: ## Clean build artifacts
# 	@echo "${YELLOW}Cleaning...${WHITE}"
	@$(call colored-echo,"Cleaning...")
	@rm -rf $(BIN_DIR)
	@$(call colored-echo,"done!\\n")

.PHONY: help
help: ## Show this help message
	@echo -e "\nUSAGE:\n"
	@echo -e " ${YELLOW}make ${GREEN}<target>${WHITE}\n"
	@echo -e "${WHITE}TARGETS:${WHITE}\n"
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*?## / {printf "  ${YELLOW}%-10s${WHITE} - %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo ""

.PHONY: generate-certs
generate-certs: --clean-certs --gen-ca-cert --gen-server-cert --gen-client-certs

.PHONY: generate-proto
generate-proto:
	@$(call colored-echo,"Generating protobuf code...")
	@buf generate
	@$(call colored-echo,"done!\\n")

.PHONY: init
init: ## Setup development environment
	@$(call colored-echo,"Setting up development environment...")
	@asdf install
	@go work sync
	@go mod download
	@$(call colored-echo,"done!\\n")

.PHONY: lint
lint: ## Run linters over the source code
	@$(call colored-echo,"Running linters...")
	@buf lint
	@cd client && golangci-lint --config="$(ROOT_DIR)/.golangci.yaml" run
	@cd server && golangci-lint --config="$(ROOT_DIR)/.golangci.yaml" run
	@cd shared && golangci-lint --config="$(ROOT_DIR)/.golangci.yaml" run
	@cd worker && golangci-lint --config="$(ROOT_DIR)/.golangci.yaml" run
	@$(call colored-echo,"done!\\n")

.PHONY: mod
mod: ## Run go mod tidy over all modules and sync the workspace
	@$(call colored-echo,"Running go mod tidy and sync the workspace...")
	@cd client && go mod tidy && cd .. && go work vendor
	@cd server && go mod tidy && cd .. && go work vendor
	@cd shared && go mod tidy && cd .. && go work vendor
	@cd worker && go mod tidy && cd .. && go work vendor
	@go work sync
	@$(call colored-echo,"done!\\n")


# TODO from here

# # Run tests for all modules
# test: ## Run tests for all modules
# 	@echo "Running tests..."
# 	go work sync
# 	cd packages/product-service && go test -v -race ./...
# 	cd packages/gateway-service && go test -v -race ./...
# 	cd packages/shared && go test -v -race ./...


# .PHONEY: build
# build: ## Build all services
# 	@echo "Building all services..."
# 	cd packages/product-service && go build -o ../../bin/product-service ./main.go
# 	cd packages/gateway-service && go build -o ../../bin/gateway-service ./main.go

