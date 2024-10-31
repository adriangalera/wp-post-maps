start:
	docker-compose up -d

clean:
	docker-compose down
	docker-compose down -v

install:
	./wp-post-installation-script.sh