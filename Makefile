.PHONY: up down restart logs build certs

CERT_DIR = back-end/certs

up: certs
	docker-compose up -d

down:
	docker-compose down

restart: certs
	docker-compose down
	docker-compose build
	docker-compose up -d

logs:
	docker-compose logs -f

build: certs
	docker-compose build

certs: $(CERT_DIR)/key.pem

$(CERT_DIR)/key.pem:
	mkdir -p $(CERT_DIR)
	openssl req -x509 -newkey rsa:2048 -nodes -days 365 -subj "/CN=localhost" \
		-keyout $(CERT_DIR)/key.pem -out $(CERT_DIR)/cert.pem
