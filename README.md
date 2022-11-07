# Initial setup
```
echo "2f969ec2ee03b53670bcb5904a0cd603" > config/master.key
echo "0e61394468bff7e3f4744bdf397474c1" > config/credentials/development.key
chmod +x entrypoint.sh
cp .env.example .env
make build
make db-setup
make migrate
make seed
```

## Running the Rails app
```
make dev && make debug
http://localhost:3000/chat
Account:
  - john_snow@gmail.com/12345678
  - bronn@gmail.com/12345678
  - daenerys_targaryen@gmail.com/12345678
  - arya_stark@gmail.com/12345678
  - khal _drogo@gmail.com/12345678
  - robb_stark@gmail.com/12345678
```

## Bash
```
make bash
```

## Migrate
```
make migrate
```

## Console
```
make console
```
