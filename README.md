# Initial setup
```
echo "2f969ec2ee03b53670bcb5904a0cd603" > config/master.key
echo "0e61394468bff7e3f4744bdf397474c1" > config/credentials/development.key
chmod +x entrypoint.sh
cp .env.example .env
make build
make db-setup
make migrate
```

## Running the Rails app
```
make dev && make debug
```

## Migrate
```
make migrate
```

## Console
```
make console
```
