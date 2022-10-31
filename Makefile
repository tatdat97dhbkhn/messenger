build:
	docker-compose build

dev:
	docker-compose up -d

kill:
	docker-compose down

debug: dev
	docker attach --detach-keys="ctrl-c" $(shell docker-compose ps -q web)

bundle:
	docker exec -it project_messenger_web_1 bash -c "bundle install"

sidekiq:
	docker exec -it project_messenger_web_1 bash -c "bundle exec sidekiq"

bash:
	docker exec -it project_messenger_web_1 bash

console:
	docker exec -it project_messenger_web_1 bash -c "bin/rails c"

db-setup:
	docker-compose run --rm project_messenger_web_1 bin/rails db:setup

migrate:
	docker exec -it project_messenger_web_1 bash -c "bin/rails db:migrate"

migrate_up:
	docker exec -it project_messenger_web_1 bash -c "bin/rails db:migrate:up VERSION=$(VERSION)"

migrate_down:
	docker exec -it project_messenger_web_1 bash -c "bin/rails db:migrate:down VERSION=$(VERSION)"

routes:
	docker exec -it project_messenger_web_1 bash -c "bin/rails rails routes"

routes_grep:
	docker exec -it project_messenger_web_1 bash -c "bin/rails rails routes" | grep $(name)
