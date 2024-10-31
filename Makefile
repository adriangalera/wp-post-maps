start:
	docker-compose up -d

stop:
	docker-compose down
	docker-compose down -v

install:
	./wp-post-installation-script.sh