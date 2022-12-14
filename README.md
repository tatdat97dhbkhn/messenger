The messenger is built on the top of [Rails](https://rubyonrails.org/) and [Hotwired](https://hotwired.dev/).
This is a website designed based on Facebook messenger.

## Live demo

Official Website: [https://messenger.fly.dev/](https://messenger.fly.dev/)

https://user-images.githubusercontent.com/27503213/207297619-b7bbbcb0-0983-45f2-958d-b8088d4cfdb1.mp4

- [Requirements](#requirements)
- [Setup](#setup)
- [Start server in dev mode (live reload)](#start-server-in-dev-mode-live-reload)
- [Access Website](#access-website)
- [Env variables](#env-variables)
- [Database migrations](./doc/database-migrations.md)
- [Screenshot](#screenshot)
## Requirements

- Docker (https://www.docker.com/)

## Setup
- `echo "2f969ec2ee03b53670bcb5904a0cd603" > config/master.key`
- `echo "0e61394468bff7e3f4744bdf397474c1" > config/credentials/development.key`
- `chmod +x entrypoint_development.sh`
- `cp .env.example .env`
- `make build`
- `make db-setup`
- `make migrate`
- `make seed`

## Start server in dev mode (live reload)
- `make dev && make debug`
- `make sidekiq`

## Access Website
- http://localhost:3000/

## Env variables
- `PG_HOST` - specify Database host
- `PG_PORT` - specify Database port
- `PG_USER` - specify Database user
- `PG_PASSWORD` - specify Database user password
- `REDIS_URL` - specify Redis url

## Screenshot

![alt text](https://github.com/tatdat97dhbkhn/messenger/blob/feature/readme/app/assets/images/screenshots/sc1.png?raw=true)
![alt text](https://github.com/tatdat97dhbkhn/messenger/blob/feature/readme/app/assets/images/screenshots/sc2.png?raw=true)
![alt text](https://github.com/tatdat97dhbkhn/messenger/blob/feature/readme/app/assets/images/screenshots/sc3.png?raw=true)
![alt text](https://github.com/tatdat97dhbkhn/messenger/blob/feature/readme/app/assets/images/screenshots/sc4.png?raw=true)
