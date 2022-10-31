# Initial setup
```
cp .env.example .env
make build
make db:setup
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
