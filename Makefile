build:
	docker-compose build

dev:
	docker-compose up -d

kill:
	docker-compose down

debug: dev
	docker attach --detach-keys="ctrl-c" $(shell docker-compose ps -q web)

bundle:
	docker-compose exec web bash -c "bin/bundle install"

sidekiq:
	docker-compose exec web bash -c "bundle exec sidekiq"

bash:
	docker-compose exec web bash

console:
	docker-compose exec web bash -c "bin/rails c"

db-setup:
	docker-compose run --rm web bin/rails db:setup

migrate:
	docker-compose run --rm web bin/rails db:migrate

migrate_up:
	docker-compose exec web bash -c "bin/rails db:migrate:up VERSION=$(VERSION)"

migrate_down:
	docker-compose exec web bash -c "bin/rails db:migrate:down VERSION=$(VERSION)"

routes:
	docker-compose exec web bash -c "bin/rails rails routes"

routes_grep:
	docker-compose exec web bash -c "bin/rails rails routes" | grep $(name)

seed:
	docker-compose exec web bash -c "bin/rails db:seed"
